import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

// ignore: must_be_immutable
class SettingsProfilPage extends StatelessWidget {
  SettingsProfilPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  String? _newPassword;
  String? _confirmPassword;

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
              // ignore: avoid_print
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
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline),
                            )),
                        TextFormField(
                          controller: _loginController,
                          decoration: const InputDecoration(
                            hintText: 'rickasley',
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
                          onChanged: (value) => _newPassword = value,
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
                          onChanged: (value) => _confirmPassword = value,
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_newPassword != _confirmPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: CustomColorScheme
                                            .customPrimaryColor
                                            .withOpacity(0.5),
                                        content: const Text(
                                            'Les mots de passe ne correspondent pas',
                                            style: TextStyle(
                                                color: CustomColorScheme
                                                    .customOnSurface,
                                                fontSize: 17)),
                                      ),
                                    );
                                    return;
                                  }
                                  cubit.updateUser(_loginController
                                      .text); // Pass the new login to the updateUser method

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: CustomColorScheme
                                          .customPrimaryColor
                                          .withOpacity(0.5),
                                      content: const Text(
                                        'Un email a été envoyé pour modifier le mot de passe',
                                        style: TextStyle(
                                            color: CustomColorScheme
                                                .customOnSurface,
                                            fontSize: 17),
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text("Sauvegarder")))
                    ],
                  )))
        ],
      ))));
    });
  }
}
