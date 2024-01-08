import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<EmailWidget> createState() => _EmailWidgetState(controller);
}

class _EmailWidgetState extends State<EmailWidget> {
  final TextEditingController _controller;

  _EmailWidgetState(this._controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: CustomColorScheme.customOnPrimary,
        hintText: 'you@copainderoute.com',
        labelText: 'Adresse mail',
      ),
      style: const TextStyle(color: CustomColorScheme.customOnSurface),
      validator: (value) {
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
            .hasMatch(value!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Veuillez entrer une adresse email valide',
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
          return 'Adresse mail invalide';
        } else {
          BlocProvider.of<LoginCubit>(context).registerEmailField = value;
          return null;
        }
      },
    );
  }
}