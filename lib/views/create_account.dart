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
            SnackBar(
              content: const Text(
                'Un email confirmant la création du compte a été envoyé à l’adresse mail spécifiée',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor:
                  CustomColorScheme.customOnPrimary.withOpacity(0.5),
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.all(.0),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is RegisterFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Une erreur est survenue lors de la création du compte',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor:
                  CustomColorScheme.customOnPrimary.withOpacity(0.5),
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.all(.0),
            ),
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
                      const EmailWidget(),
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
          foregroundColor: CustomColorScheme.customOnPrimary,
          backgroundColor: CustomColorScheme.customSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(400, 50),
        ),
        child: const Text('Créez votre compte'),
      ),
    );
  }
}
