import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class PasswordConfirmationWidget extends StatefulWidget {
  const PasswordConfirmationWidget({super.key});
  @override
  PasswordConfirmationWidgetState createState() =>
      PasswordConfirmationWidgetState();
}

class PasswordConfirmationWidgetState
    extends State<PasswordConfirmationWidget> {
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Mot de passe',
            labelText: 'Mot de passe',
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            _password = value;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: CustomColorScheme.customError),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: CustomColorScheme.customOnPrimary,
            hintText: 'password',
            labelText: 'Confirm your password',
          ),
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (value != _password) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Les mots de passe ne correspondent pas',
                    style: TextStyle(
                        color: CustomColorScheme.customError,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor:
                      CustomColorScheme.customOnPrimary.withOpacity(0.6),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.all(.0),
                ),
              );
              return '';
            }
            return null;
          },
        ),
      ],
    );
  }
}
