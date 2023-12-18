import 'package:flutter/material.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({Key? key}) : super(key: key);
  @override
  PasswordWidgetState createState() => PasswordWidgetState();
}

class PasswordWidgetState extends State<PasswordWidget> {
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
            fillColor: CustomColorScheme.customOnPrimary,
            hintText: 'Mot de passe',
            labelText: 'Mot de passe',
          ),
          style: const TextStyle(color: CustomColorScheme.customPrimaryColor),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez entrer votre mot de passe';
            }
            return null;
          },
        ),
      ],
    );
  }
}
