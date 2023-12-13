import 'package:copains_de_route/views/login_screen.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC45C23),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              width: 230.0,
              height: 250.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/logo_copains_de_route_withoutbg.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Entrez votre e-mail pour la récupération de votre mot de passe :",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    _loginField(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: const Text(
                            'Un email permettant de réinitialiser le mot de passe a été envoyé à l’email spécifié',
                            style: TextStyle(
                              // Define the text style
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.4),
                          duration: const Duration(seconds: 5),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin: const EdgeInsets.all(.0),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show the SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFFDD856),
                        onPrimary: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: const Text('Réinitialiser le mot de passe'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'you@copainderoute.com',
        labelText: 'Email',
      ),
    );
  }
}
