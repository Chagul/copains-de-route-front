import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({Key? key}) : super(key: key);
  @override
  PasswordWidgetState createState() => PasswordWidgetState();
}

class PasswordWidgetState extends State<PasswordWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _controller,
          onChanged: (String value) {
            BlocProvider.of<LoginCubit>(context).passwordField = value;
          },
          obscureText: true,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: CustomColorScheme.customOnPrimary,
            hintText: 'Mot de passe',
            labelText: 'Mot de passe',
          ),
          style: const TextStyle(color: CustomColorScheme.customOnSurface),
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
