import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SettingsProfilPage extends StatelessWidget {
  const SettingsProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = BlocProvider.of<ProfilViewCubit>(context);

      return SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
                  child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back)),
              const Text("Paramètres",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
              onTap: () => {print("change avatar")},
              child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: CustomColorScheme.customPrimaryColor,
                  child: CircleAvatar(
                      radius: 47,
                      backgroundImage: NetworkImage(
                          'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png')))),
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
              child: Form(
                  child: Column(
                children: [
                  Column(children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        )),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'rick.asley@gmail.com',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Column(children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mot de passe actuel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        )),
                    TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Mot de passe actuel',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Column(children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Nouveau mot de passe",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        )),
                    TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Nouveau mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Column(children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Confirmer le nouveau mot de passe",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        )),
                    TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Confirmer le nouveau mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () =>
                              {cubit.updateUser(), Navigator.of(context).pop()},
                          child: const Text("Sauvegarder")))
                ],
              )))
        ],
      ))));
    });
  }
}
