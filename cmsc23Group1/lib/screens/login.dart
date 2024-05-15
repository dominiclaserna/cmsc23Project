import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/signup.dart';
import '../screens/user_details.dart'; // Import UserDetailsPage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _passwordErrorText;
  Color _passwordBorderColor = Colors.grey;

  String? _emailErrorText;
  Color _emailBorderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      key: const Key('emailField'),
      controller: emailController,
      decoration: InputDecoration(
        hintText: "Email",
        errorText: _emailErrorText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _emailBorderColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter email.";
        }
        return null;
      },
    );

    final password = TextFormField(
      key: const Key('pwField'),
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        errorText: _passwordErrorText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _passwordBorderColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter password.";
        }
        return null;
      },
    );

    final loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Remove the previous error text upon clicking the log in button again
            setState(() {
              _emailErrorText = null;
              _emailBorderColor = Colors.grey;
              _passwordErrorText = null;
              _passwordBorderColor = Colors.grey;
            });

            String? result = await context.read<AuthProvider>().signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

            if (result == null) {
              // Navigate to user details page upon successful login
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(),
                ),
              );
            } else {
              switch (result) {
                case 'user-not-found':
                  setState(() {
                    _emailErrorText = "No user found for that email.";
                    _emailBorderColor = Colors.red;
                  });
                  break;
                case 'wrong-password':
                  setState(() {
                    _passwordErrorText =
                        "Wrong password provided for that user.";
                    _passwordBorderColor = Colors.red;
                  });
                  break;
              }
            }
          }
        },
        child: const Text('Log In', style: TextStyle(color: Colors.black)),
      ),
    );

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
        },
        child: const Text('Sign Up as Donor',
            style: TextStyle(color: Colors.black)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              email,
              password,
              loginButton,
              signUpButton,
            ],
          ),
        ),
      ),
    );
  }
}
