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
            const SnackBar(
                content: Text('Veuillez entrer une adresse email valide')),
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
