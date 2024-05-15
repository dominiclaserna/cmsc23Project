import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  String? _passwordErrorText;
  String? _emailErrorText;

  @override
  Widget build(BuildContext context) {
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              TextFormField(
                controller: firstController,
                decoration: const InputDecoration(
                  hintText: "First Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter first name.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastController,
                decoration: const InputDecoration(
                  hintText: "Last Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter last name.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _emailErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  }
                  // Validate email format
                  if (!RegExp(
                          r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                      .hasMatch(value)) {
                    return "Please enter a valid email address.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  errorText: _passwordErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password.";
                  }
                  // Validate password length
                  if (value.length < 6) {
                    return "Password must be at least 6 characters.";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Remove previous error text upon clicking the sign-up button again
                    setState(() {
                      _emailErrorText = null;
                      _passwordErrorText = null;
                    });

                    String fullName =
                        '${firstController.text.trim()} ${lastController.text.trim()}';
                    String? result = await context.read<AuthProvider>().signUp(
                        emailController.text,
                        passwordController.text,
                        firstController.text,
                        lastController.text);

                    if (result != null) {
                      switch (result) {
                        case 'weak-password':
                          setState(() {
                            _passwordErrorText =
                                "The password provided is too weak.";
                          });
                          break;
                        case 'email-already-in-use':
                          setState(() {
                            _emailErrorText =
                                "An account already exists for that email.";
                          });
                          break;
                      }
                    } else {
                      // Navigate to another screen upon successful sign-up
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Sign up',
                    style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    const Text('Back', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
