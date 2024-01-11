import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:copains_de_route/components/login_screen/email_widget.dart';
import 'package:copains_de_route/components/login_screen/login_widget.dart';
import 'package:copains_de_route/components/login_screen/password_confirm_widget.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is RegisteredState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Votre compte a été créé avec succès!'),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is RegisterFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Une erreur est survenue lors de la création du compte',
            )),
          );
        }
        if (state is RegisterUserAlreadyTakenState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Cet utilisateur existe déjà',
            )),
          );
        }
        if (state is RegisterEmailAlreadyTakenState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Cet email existe déjà',
            )),
          );
        }
      },
      child: Scaffold(
        backgroundColor: CustomColorScheme.customPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage('assets/icon.png'),
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: () async {
                                await getImage();
                              },
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      EmailWidget(controller: emailController),
                      const SizedBox(height: 20),
                      const LoginWidget(),
                      const SizedBox(height: 20),
                      const PasswordConfirmationWidget(),
                      const SizedBox(height: 20),
                      _submitButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_image != null) {
              Uint8List bytes = _image!.readAsBytesSync();
              String base64Image = base64.encode(bytes);
              BlocProvider.of<LoginCubit>(context).base64ProfilePic =
                  base64Image;
              BlocProvider.of<LoginCubit>(context).profilePicFormat =
                  p.extension(_image!.path);
            }
            BlocProvider.of<LoginCubit>(context).register();
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: CustomColorScheme.customOnSurface,
          backgroundColor: CustomColorScheme.customSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(400, 50),
        ),
        child: const Text('Créez votre compte',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
