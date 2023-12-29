import 'package:copains_de_route/components/commons/card_statistiques.dart';
import 'package:copains_de_route/components/commons/custom_title.dart';
import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/profil/friend_inkwell.dart';
import 'package:copains_de_route/components/profil/friend_list.dart';
import 'package:copains_de_route/components/profil/settings_profil.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilViewCubit, ProfilViewState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return const LoadingWidget();
      } else {
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
                    return SettingsProfilPage();
                  }));
                },
                icon: const Icon(Icons.settings),
              ),
            ),
            Column(children: [
              ProfilePictureUtils.getUserProfilePicWidget(context),
              const SizedBox(height: 10),
              if (state is MyProfileState)
                Text(
                  state.login,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
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
                                  if (BlocProvider.of<LoginCubit>(context)
                                      .acceptedFriends
                                      .isNotEmpty)
                                    FriendInkwell(
                                        friend:
                                            BlocProvider.of<LoginCubit>(context)
                                                .acceptedFriends[0]),
                                  if (BlocProvider.of<LoginCubit>(context)
                                          .acceptedFriends
                                          .length >
                                      1)
                                    FriendInkwell(
                                        friend:
                                            BlocProvider.of<LoginCubit>(context)
                                                .acceptedFriends[1]),
                                ]),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => FriendList(
                                                      friends: BlocProvider.of<
                                                                  LoginCubit>(
                                                              context)
                                                          .acceptedFriends)))
                                        },
                                    child: const Text("Voir plus",
                                        style: TextStyle(
                                            color: CustomColorScheme
                                                .customOnSecondary,
                                            fontSize: 20))))
                          ]))),
                  if (state is MyProfileState)
                    CardStatistiques(
                        evenementJoinedNumber:
                            state.userdto.numberEventsParticipated.toString(),
                        evenementCreatedNumber:
                            state.userdto.numberEventsCreated.toString(),
                        kmDriven: state.userdto.distanceTraveled.toString(),
                        co2Saved: state.userdto.co2NotEmitted.toString())
                ],
              ),
            )
          ])),
        ));
      }
    });
  }
}
