import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:copains_de_route/model/update_user_dto.dart';
import 'package:path/path.dart' as p;
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SettingsProfilPage extends StatefulWidget {
  const SettingsProfilPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsProfilPageState();
}

class SettingsProfilPageState extends State<SettingsProfilPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  File? _image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is UserAlreadyTakenState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Cet identifiant est déjà pris",
          ),
        ));
      }
      if (state is UserRefreshedState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            state.message,
          ),
        ));
        Navigator.pop(context);
      }
      if (state is UserRefreshedFailState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Erreur lors de la mise à jour du profil",
          ),
        ));
      }
    }, builder: (context, state) {
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
                if (_image == null) ...{
                  InkWell(
                    onTap: () async {
                      await getImage();
                    },
                    child: ProfilePictureUtils.getUserProfilePicWidget(context),
                  ),
                } else
                  InkWell(
                    onTap: () async {
                      await getImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(_image!),
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
                                "Identifiant",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _loginController,
                              decoration: InputDecoration(
                                hintText: cubit.user.login,
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  CustomColorScheme.customSecondaryColor,
                              foregroundColor:
                                  CustomColorScheme.customOnSurface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
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
                                if (_image != null) {
                                  Uint8List bytes = _image!.readAsBytesSync();
                                  String base64Image = base64.encode(bytes);
                                  cubit.base64ProfilePic = base64Image;
                                  cubit.profilePicFormat =
                                      p.extension(_image!.path);

                                  cubit.updateUser(UpdateUserDTO(
                                      login: _loginController.text,
                                      oldPassword:
                                          _currentPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                      base64ProfilePic: cubit.base64ProfilePic!,
                                      profilePicFormat:
                                          cubit.profilePicFormat!));
                                } else {
                                  cubit.updateUser(UpdateUserDTO(
                                      login: _loginController.text,
                                      oldPassword:
                                          _currentPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                      base64ProfilePic: null,
                                      profilePicFormat: null));
                                }
                              }
                            },
                            child: const Text("Sauvegarder",
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
