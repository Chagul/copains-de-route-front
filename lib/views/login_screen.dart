import 'package:flutter/material.dart';
import 'package:copains_de_route/views/create_account.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

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
                      child: _forgotPassword(),
                    ),
                    _button(),
                    SizedBox(height: 20),
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
      fillColor: Colors.white,
      hintText: '@login',
      labelText: 'Login'
      ),

      style: const TextStyle(color: Colors.black), // Set the text color to black
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
      fillColor: Colors.white,

      hintText: 'password',
      labelText: 'Password'
      ),
      
      style: const TextStyle(color: Colors.black), // Set the text color to black
      onChanged: (String value){},
  );
    
}

Widget _forgotPassword(){
  return TextButton(
    onPressed: (){},
    child: Text('Mot de passe oublié ? '),
    style : TextButton.styleFrom(
      primary: Colors.white,
    ),
  );
}

Widget _button() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: ElevatedButton(
      onPressed: () {},
      child: Text('Connexion'),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFFDD856),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(400, 50), // Use minimumSize to set the button size
      ),
    ),
  );
}


Widget _creationCompte(BuildContext context){
  return TextButton(
    onPressed: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
          },
    child: Text('Pas encore de compte ? Créez en un !'),
    style : TextButton.styleFrom(
      primary: Colors.white,
    ),
  );
}

