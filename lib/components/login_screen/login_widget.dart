import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
    return TextFormField(
      controller: _controller,
      onChanged: (String value) {
        BlocProvider.of<LoginCubit>(context).loginField = value;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: CustomColorScheme.customOnPrimary,
        hintText: 'Identifiant',
        labelText: 'Identifiant',
      ),
      style: const TextStyle(color: CustomColorScheme.customOnSurface),
      validator: (value) {
        if (value!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Veuillez entrer votre identifiant',
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
