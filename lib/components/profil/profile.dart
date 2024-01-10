import 'package:copains_de_route/components/commons/card_statistiques.dart';
import 'package:copains_de_route/components/commons/custom_title.dart';
import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/profil/friend_inkwell.dart';
import 'package:copains_de_route/components/profil/friend_list.dart';
import 'package:copains_de_route/components/profil/settings_profil.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is UserLoadingState || state is UserRefreshingState) {
        return const LoadingWidget();
      } else if (state is UserLoadedState || state is UserRefreshedState) {
        return SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
            const CustomTitle(
              text: "Profil",
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const SettingsProfilPage();
                  }));
                },
                icon: const Icon(Icons.settings),
              ),
            ),
            Column(children: [
              ProfilePictureUtils.getUserProfilePicWidget(context),
              const SizedBox(height: 10),
              Text(
                context.read<LoginCubit>().user.login,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Liste d'amis:",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline))),
                  Card(
                      color:
                          CustomColorScheme.customPrimaryColor.withOpacity(0.5),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (context
                                      .read<LoginCubit>()
                                      .acceptedFriends
                                      .isEmpty)
                                    const Text("Aucun ami",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  if (context
                                      .read<LoginCubit>()
                                      .acceptedFriends
                                      .isNotEmpty)
                                    FriendInkwell(
                                        friend: context
                                            .read<LoginCubit>()
                                            .acceptedFriends[0]),
                                  const SizedBox(height: 10),
                                  if (context
                                          .read<LoginCubit>()
                                          .acceptedFriends
                                          .length >
                                      1)
                                    FriendInkwell(
                                        friend: context
                                            .read<LoginCubit>()
                                            .acceptedFriends[1]),
                                ]),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () => {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => BlocProvider<
                                                      AddFriendCubit>(
                                                  create: (context) =>
                                                      AddFriendCubit(
                                                          AddFriendInitialState()),
                                                  child: FriendList(
                                                      friends: context
                                                          .read<LoginCubit>()
                                                          .acceptedFriends))))
                                        },
                                    child: const Text("Voir plus",
                                        style: TextStyle(
                                            color: CustomColorScheme
                                                .customOnSecondary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))))
                          ]))),
                  CardStatistiques(
                      evenementJoinedNumber: context
                          .read<LoginCubit>()
                          .user
                          .numberEventsParticipated
                          .toString(),
                      evenementCreatedNumber: context
                          .read<LoginCubit>()
                          .user
                          .numberEventsCreated
                          .toString(),
                      kmDriven: context
                          .read<LoginCubit>()
                          .user
                          .distanceTraveled
                          .toString(),
                      co2Saved: context
                          .read<LoginCubit>()
                          .user
                          .co2NotEmitted
                          .toString())
                ],
              ),
            )
          ])),
        ));
      } else {
        return const Align(
            alignment: Alignment.center,
            child: Text(
              "Erreur réseau : Les données de l'utilisateur n'ont pas pu être chargées",
              style: TextStyle(color: CustomColorScheme.customOnSecondary),
            ));
      }
    });
  }
}
