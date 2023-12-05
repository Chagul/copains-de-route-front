import 'package:copains_de_route/components/profil/friend_list.dart';
import 'package:copains_de_route/components/profil/friend_profile.dart';
import 'package:copains_de_route/components/profil/settings_profil.dart';
import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = BlocProvider.of<ProfilViewCubit>(context);
      return SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          const Text("Profil"),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                          value: cubit, child: const SettingsProfilPage()))),
                  icon: const Icon(Icons.settings))),
          const Column(children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: CustomColorScheme.customPrimaryColor,
                child: CircleAvatar(
                    radius: 47,
                    backgroundImage: NetworkImage(
                        'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png'))),
            SizedBox(height: 10),
            Text("Rick",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Liste d'amis:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))),
                Card(
                    color: CustomColorScheme.customPrimaryColor,
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
                                                      BlocProvider.value(
                                                          value: cubit,
                                                          child:
                                                              const FriendProfile()))),
                                        },
                                    child: const Row(children: [
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: CustomColorScheme
                                              .customPrimaryColor,
                                          child: CircleAvatar(
                                              radius: 27,
                                              backgroundImage: NetworkImage(
                                                  'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png'))),
                                      SizedBox(width: 10),
                                      Text(
                                        "Ami 1",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ])),
                                SizedBox(height: 10),
                                InkWell(
                                    onTap: () =>
                                        BlocProvider.of<ProfilViewCubit>(
                                                context)
                                            .friendClicked(2),
                                    child: const Row(children: [
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: CustomColorScheme
                                              .customPrimaryColor,
                                          child: CircleAvatar(
                                              radius: 27,
                                              backgroundImage: NetworkImage(
                                                  'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png'))),
                                      SizedBox(width: 10),
                                      Text("Ami 2",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold))
                                    ])),
                              ]),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                                  value: cubit,
                                                  child: const FriendList())))},
                                  child: const Text("Voir plus",
                                      style: TextStyle(
                                          color: CustomColorScheme
                                              .customOnSecondary,
                                          fontSize: 20))))
                        ]))),
                const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Statistiques:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))),
                const Card(
                    color: CustomColorScheme.customPrimaryColor,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Column(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  Icon(Icons.directions_bike,
                                      color:
                                          CustomColorScheme.customOnSecondary),
                                  SizedBox(width: 10),
                                  Text(
                                    "A participé à 15 événement",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Icon(Icons.pin_drop,
                                      color:
                                          CustomColorScheme.customOnSecondary),
                                  SizedBox(width: 10),
                                  Text(
                                    "A créé à 5 événements",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Icon(Icons.map,
                                      color:
                                          CustomColorScheme.customOnSecondary),
                                  SizedBox(width: 10),
                                  Text(
                                    "A parcouru à 60 km",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Icon(Icons.co2,
                                      color:
                                          CustomColorScheme.customOnSecondary),
                                  SizedBox(width: 10),
                                  SizedBox(width: 10),
                                  Text(
                                    "A économisé 5820g de CO2",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                                SizedBox(height: 10),
                              ]),
                        ])))
              ],
            ),
          )
        ])),
      ));
    });
  }
}
