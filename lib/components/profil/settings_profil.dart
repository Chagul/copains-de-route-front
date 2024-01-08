import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingsProfilPage extends StatelessWidget {
  SettingsProfilPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();

      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      "Paramètres",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => {("change avatar")},
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: CustomColorScheme.customPrimaryColor,
                    child: CircleAvatar(
                      radius: 47,
                      backgroundImage: NetworkImage(
                        'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _loginController,
                              decoration: const InputDecoration(
                                hintText: 'rickasley',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Mot de passe actuel",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _currentPasswordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: 'Mot de passe actuel',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Nouveau mot de passe",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: 'Nouveau mot de passe',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Confirmer le nouveau mot de passe",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _confirmNewPasswordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: 'Confirmer le nouveau mot de passe',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_newPasswordController.text !=
                                    _confirmNewPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Les mots de passe ne correspondent pas",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                  cubit.updateUser(_loginController.text,
                                  _currentPasswordController.text,
                                  _newPasswordController.text);

                                  if (state is UserRefreshedState){
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                      content: Text(
                                        state.message,
                                      ),
                                    )
                                  );
                                }
                                else if (state is UserRefreshedFailState){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Erreur lors de la mise à jour du profil",
                                      ),
                                    )
                                  );
                                }

                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Sauvegarder"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

}