import 'dart:typed_data';

import 'package:copains_de_route/utils/pickimage.dart';
import 'package:copains_de_route/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _password;
 // String? _confirmPassword;
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() => _image = img);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC45C23),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              width: 230.0,
              height: 250.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage('assets/iconn.png'),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _emailField(),
                    const SizedBox(height: 20),
                    _loginField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    const SizedBox(height: 20),
                    _confirmPasswordField(),
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
    );
  }

  Widget _emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'you@copainderoute.com',
        labelText: 'Email',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer votre adresse email';
        }
        // Utilisez une expression régulière pour vérifier le format de l'email
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
          return 'Veuillez entrer un email valide';
        }
        return null;
      },
    );
  }

  Widget _loginField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: '@login',
        labelText: 'Login',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer votre login';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'password',
        labelText: 'Password',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer votre mot de passe';
        }
 },
        onChanged: (value) {
         _password = value;  },

       
     
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'password',
        labelText: 'Confirm your password',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez confirmer votre mot de passe';
        }
        else {
          if (value != _password) {
            return 'Les mots de passe ne correspondent pas';
          }
        }
      },
    );
  }

 Widget _submitButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Affichez un SnackBar avec un message de confirmation.
          ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Un email confirmant la création  du compte a été envoyé à  l’adresse mail spécifiée',
                    style: TextStyle(
                      // Define the text style
                      color: Colors.black, // Set the text color to white
                    ),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.5), // Set the background color to orange with 90% opacity
                  duration: const Duration(seconds: 10), // Set the duration to 10 seconds
                  behavior: SnackBarBehavior.floating, // Set the SnackBar behavior to floating
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  ),
                  margin: const EdgeInsets.all(10.0), // Margin from the edges
                ),
              );
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          
        }
      },

        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFFFDD856),
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
