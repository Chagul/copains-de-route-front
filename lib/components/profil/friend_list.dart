import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class FriendList extends StatelessWidget {
  final List<FriendsDTO> friends;
  const FriendList({Key? key, required this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = BlocProvider.of<ProfilViewCubit>(context);
      if (cubit.state is MyProfileState) {
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
                        onPressed: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return BlocProvider.value(
                                  value: cubit, child: const Text("test"));
                            })),
                        icon: const Icon(Icons.add)))
              ],
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    color: CustomColorScheme.customPrimaryColor,
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
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("Vos Amis",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))
                              ])),
                          const SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: const CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png')),
                                      title: const Text("Rick Astley",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      trailing: IconButton(
                                          onPressed: () => {},
                                          icon: const Icon(Icons.delete)),
                                    );
                                  }))
                        ],
                      ),
                    ))),
          ])),
        ));
      } else if (cubit.state is OtherProfileState) {
        return const Text("OTHER PRFILE");
      } else if (cubit.state is LoadingState) {
        return const LoadingWidget();
      } else {
        return Container();
      }
    });
  }
}
