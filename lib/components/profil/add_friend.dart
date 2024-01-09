import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/profil/friend_request_tile.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFriendCubit, AddFriendState>(
        listener: (context, state) {
      if (state is FriendRequestAlreadyExistsState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Une demande d'ami a déjà été envoyée à cet utilisateur")));
      }
      if (state is FriendRequestCannotAddItSelfState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Vous ne pouvez pas vous ajouter vous même")));
      }
      if (state is AddFriendFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("L'ami n'a pas pu être ajouté")));
      }
      if (state is AddFriendSucceedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Une demande d'ami a été envoyée")));
      }
      if (state is AcceptFriendSucceedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("La demande d'ami a été acceptée")));
      }
      if (state is AcceptFriendFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Erreur : La demande d'ami n'a pas pu être acceptée")));
      }
      if (state is DenyFriendSucceedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("La demande d'ami a été refusée")));
      }
      if (state is DenyFriendFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Erreur : La demande d'ami n'a pas pu être refusée")));
      }
      if (state is AcceptOrDenyFriendFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Une erreur est survenue")));
      }
    }, builder: (context, state) {
      final cubitFriend = BlocProvider.of<AddFriendCubit>(context);
      return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    onPressed: () => {
                          BlocProvider.of<LoginCubit>(context).refreshUser(),
                          Navigator.of(context).pop()
                        },
                    icon: const Icon(Icons.arrow_back)),
              ]),
              const Text(
                "Ajouter un ami",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: cubitFriend.loginToAdd,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Identifiant"),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColorScheme.customSecondaryColor),
                  child: const Text(
                    "Envoyer une demande d'ami",
                    style: TextStyle(color: CustomColorScheme.customOnSurface),
                  ),
                  onPressed: () {
                    cubitFriend.addFriend();
                    Navigator.of(context).pop();
                  }),
              const SizedBox(height: 20),
              const Divider(
                indent: 50,
                endIndent: 50,
                color: CustomColorScheme.customOnSurface,
              ),
              const SizedBox(height: 20),
              const Text(
                "Demandes en attente",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                final cubitLogin = BlocProvider.of<LoginCubit>(context);
                if ((state is UserLoadedState || state is UserRefreshedState) &&
                    cubitLogin.pendingRequests.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color:
                          CustomColorScheme.customPrimaryColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColorScheme.customOnSurface),
                            ),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cubitLogin.pendingRequests.length,
                                itemBuilder: (context, index) {
                                  return FriendRequestTile(
                                    friend: cubitLogin.pendingRequests[index],
                                    loginUser: cubitLogin.user.login,
                                  );
                                })),
                      ),
                    ),
                  );
                } else if ((state is UserLoadedState ||
                        state is UserRefreshedState) &&
                    cubitLogin.pendingRequests.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Aucune demande d'ami en attente"),
                  );
                } else {
                  return const LoadingWidget();
                }
              })
            ],
          ),
        ),
      );
    });
  }
}
