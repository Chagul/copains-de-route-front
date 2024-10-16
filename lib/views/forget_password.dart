import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copains_de_route/components/login_screen/email_widget.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ForgotPasswordContent();
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  @override
  _ForgotPasswordContentState createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorScheme.customPrimaryColor,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ResetPasswordLinkSentState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Un email vous a été envoyé pour réinitialiser votre mot de passe')),
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 50),
                Container(
                  width: 230.0,
                  height: 250.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/logo_copains_de_route_withoutbg.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Entrez votre e-mail pour la récupération de votre mot de passe :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        const SizedBox(height: 20),
                        EmailWidget(controller: emailController),
                        const SizedBox(height: 20),
                        _submitButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context
                .read<LoginCubit>()
                .sendResetPasswordLink(emailController.text);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                'Un email vous a été envoyé pour réinitialiser votre mot de passe',
              )),
            );
            Navigator.of(context).pop();
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: CustomColorScheme.customPrimaryColor,
          backgroundColor: CustomColorScheme.customSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(400, 50),
        ),
        child: const Text('Réinitialiser le mot de passe',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColorScheme.customOnSurface)),
      ),
    );
  }
}
