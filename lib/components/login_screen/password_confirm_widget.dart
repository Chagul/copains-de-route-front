import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordConfirmationWidget extends StatefulWidget {
  const PasswordConfirmationWidget({Key? key}) : super(key: key);
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
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Mot de passe',
            labelText: 'Mot de passe',
          ),
          style: const TextStyle(color: CustomColorScheme.customOnSurface),
          onChanged: (value) {
            _password = value;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: CustomColorScheme.customError),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: CustomColorScheme.customOnPrimary,
            hintText: 'Mot de passe',
            labelText: 'Confirmer votre mot de passe',
          ),
          style: const TextStyle(color: CustomColorScheme.customOnSurface),
          validator: (value) {
            if (value != _password) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Les mots de passe ne correspondent pas.')),
              );
              return 'Mot de passe invalide';
            } else {
              BlocProvider.of<LoginCubit>(context).registerPassswordField =
                  value!;
              return null;
            }
          },
        ),
      ],
    );
  }
}
