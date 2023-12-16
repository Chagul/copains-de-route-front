import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:copains_de_route/views/create_account.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorScheme.customPrimaryColor,
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
                  image: AssetImage('assets/logo_copains_de_route_withoutbg.png'),
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
                    _loginField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _forgotPassword(context),
                    ),
                    _button(context),
                    const SizedBox(height: 20),
                    _creationCompte(context),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}




Widget _loginField(){
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
     decoration : InputDecoration(
      border: UnderlineInputBorder(
      borderRadius:BorderRadius.circular(5.0)),
      filled : true,
      fillColor: CustomColorScheme.customOnPrimary,
      hintText: '@login',
      labelText: 'Login'
      ),

      style: const TextStyle(color: CustomColorScheme.customOnSecondary), // Set the text color to black
      onChanged: (String value){},
  );
    
}

Widget _passwordField(){
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    obscureText: true,
    decoration : InputDecoration(

      border: UnderlineInputBorder(
      borderRadius:BorderRadius.circular(5.0)),
      filled : true,
      fillColor: CustomColorScheme.customOnPrimary,

      hintText: 'password',
      labelText: 'Password'
      ),
      
      style: const TextStyle(color: CustomColorScheme.customOnSecondary), // Set the text color to black
      onChanged: (String value){},
  );
    
}

Widget _forgotPassword(BuildContext context){
  return  TextButton(
    onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPassword()),
      );
    },
    style : TextButton.styleFrom(
      foregroundColor: CustomColorScheme.customOnPrimary,
    ),
    child: const Text('Mot de passe oublié ? '),
  );
}

Widget _button(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: ElevatedButton(
      onPressed: () {        
      },
      style: ElevatedButton.styleFrom(
        primary: CustomColorScheme.customSecondaryColor,
        onPrimary: CustomColorScheme.customOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: const Size(400, 50),
      ),
      child: const Text('Connexion'),
    ),
  );
}



Widget _creationCompte(BuildContext context){
  return TextButton(
    onPressed: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccount()));
          },
    style : TextButton.styleFrom(
      foregroundColor: CustomColorScheme.customOnPrimary,
    ),
    child: const Text('Pas encore de compte ? Créez en un !'),
  );
}

