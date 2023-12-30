import 'package:copains_de_route/components/profil/add_friend.dart';
import 'package:copains_de_route/components/profil/friend_list_tile.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class FriendList extends StatelessWidget {
  final List<FriendsDTO> friends;
  const FriendList({Key? key, required this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddFriendCubit, AddFriendState>(
          listener: (context, state) {
        if (state is FriendRequestAlreadyExistsState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Une demande d'ami a déjà été envoyée à cet utilisateur")));
        }
        if (state is AddFriendFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("L'ami n'a pas pu être ajouté")));
        }
        if (state is AddFriendSucceedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Une demande d'ami a été envoyée")));
        }
      }, builder: (context, state) {
        final cubitFriend = BlocProvider.of<AddFriendCubit>(context);
        final cubitLogin = BlocProvider.of<LoginCubit>(context);

        return SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back)),
                const Text("Ma liste d'amis",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddFriend(cubit: cubitFriend)));
                      }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                    color:
                        CustomColorScheme.customPrimaryColor.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(children: [
                                Icon(
                                  Icons.people,
                                  size: 60,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 20),
                                Text("Vos Amis",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))
                              ])),
                          const SizedBox(height: 20),
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cubitLogin.acceptedFriends.length,
                                  itemBuilder: (context, index) {
                                    return FriendListTile(
                                        friend:
                                            cubitLogin.acceptedFriends[index],
                                        loginUser: cubitLogin.user.login);
                                  }))
                        ],
                      ),
                    ))),
          ])),
        ));
      }),
    );
  }
}
