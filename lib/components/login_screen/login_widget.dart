import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: CustomColorScheme.customOnPrimary,
        hintText: '@login',
        labelText: 'Login',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Veuillez entrer votre login',
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
              margin: const EdgeInsets.all(10.0),
            ),
          );
          return '';
        }
        return null;
      },
    );
  }
}
