import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC45C23),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              width: 230.0,
              height: 250.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _emailField(),
                    const SizedBox(height: 20),
                    _loginField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    const SizedBox(height: 20),
                    _confirmPasswordField(),
                    const SizedBox(height: 20),
                    _submitButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _emailField() {
  return TextFormField(
    controller: _emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: 'you@copainderoute.com',
      labelText: 'Email',
    ),
    style: const TextStyle(color: Colors.black),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Veuillez entrer votre adresse email';
      }
      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
        return 'Veuillez entrer un email valide';
      }
      return null;
    },
  );
}


  Widget _loginField() {
    return TextFormField(
      controller: _loginController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: '@login',
        labelText: 'Login',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer votre login';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'password',
        labelText: 'Password',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer votre mot de passe';
        }
        return null;
      },
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'password',
        labelText: 'Confirm your password',
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez confirmer votre mot de passe';
        }
        return null;
      },
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String email = _emailController.text;
            String login = _loginController.text;
            String password = _passwordController.text;
            String confirmPassword = _confirmPasswordController.text;

            if (kDebugMode) {
              print('Email: $email');
            }
            print('Login: $login');
            print('Password: $password');
            print('Confirm Password: $confirmPassword');
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFFFDD856),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(400, 50),
        ),
        child: const Text('Créer un compte'),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
