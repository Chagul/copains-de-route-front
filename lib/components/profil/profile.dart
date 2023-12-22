import 'package:copains_de_route/components/commons/card_statistiques.dart';
import 'package:copains_de_route/components/commons/card_statistiques_friend.dart';
import 'package:copains_de_route/components/commons/custom_title.dart';
import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/commons/row_image_text.dart';
import 'package:copains_de_route/components/profil/friend_list.dart';
import 'package:copains_de_route/components/profil/settings_profil.dart';
import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return BlocProvider(
                            create: (context) => ProfilViewCubit(),
                            child: const SettingsProfilPage());
                      }));
                    },
                    icon: const Icon(Icons.settings))),
            Column(children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      CustomColorScheme.customPrimaryColor.withOpacity(0.5),
                  child: const CircleAvatar(
                      radius: 47,
                      backgroundImage: NetworkImage(
                          'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png'))),
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
                          CustomColorScheme.customPrimaryColor.withOpacity(0.8),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () => {
                                            BlocProvider.of<ProfilViewCubit>(
                                                    context)
                                                .friendClicked(1),
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CardStatiquesFriend())),
                                          },
                                      child: const RowImageText(
                                          image:
                                              "https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png",
                                          text: "Ami 1")),
                                //  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () => {
                                      BlocProvider.of<ProfilViewCubit>(context)
                                          .friendClicked(2),
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfilePage()))
                                    },
                                    child: const RowImageText(
                                        image:
                                            "https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png",
                                        text: "Ami 2"),
                                  ),
                                ]),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () => {
                                          BlocProvider.of<ProfilViewCubit>(
                                                  context)
                                              .moreFriendClicked(),
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FriendList()))
                                        },
                                    child: const Text("Voir plus",
                                        style: TextStyle(
                                            color: CustomColorScheme
                                                .customOnSecondary,
                                            fontSize: 20))))
                          ]))),
                  if (state is MyProfileState)
                    CardStatiques(
                        evenementJoinedNumber:
                            state.numberEventsParticipated.toString(),
                        evenementCreatedNumber:
                            state.numberEventsCreated.toString(),
                        kmDriven: state.distanceTraveled.toString(),
                        co2Saved: state.co2NotEmitted.toString())
                ],
              ),
            )
          ])),
        ));
      }
    });
  }
}



/* return SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
                    child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back)),
            const Text("Profil",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          const Align(
              alignment: Alignment.topLeft,
              child: Row(children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: CustomColorScheme.customPrimaryColor,
                    child: CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                            'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png'))),
                SizedBox(width: 10),
                Text(
                  "Ami 1",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ])),
        ]))));
      } else {
        return const LoadingWidget();
      }
    });
  }
}*/
