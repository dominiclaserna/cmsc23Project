import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';
import 'signup.dart'; // Import the SignUpPage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _errorText;
  UserType _selectedUserType = UserType.donor; // Default to donor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            children: <Widget>[
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              DropdownButtonFormField<UserType>(
                value: _selectedUserType,
                onChanged: (value) {
                  setState(() {
                    _selectedUserType = value!;
                  });
                },
                items: UserType.values
                    .where((userType) => userType != UserType.admin) // Filter out admin
                    .map((UserType userType) {
                  return DropdownMenuItem<UserType>(
                    value: userType,
                    child: Text(userType.toString().split('.').last),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: emailController,
                style: const TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _errorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
                  hintText: "Password",
                  errorText: _errorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _errorText = null;
                    });

                    String? result = await context
                        .read<AuthProvider>()
                        .signIn(emailController.text, passwordController.text);

                    if (result != null) {
                      setState(() {
                        _errorText = "Invalid email or password.";
                      });
                    } else {
                      // Check if the user is allowed to log in as an organization
                      bool isOrganization = context.read<AuthProvider>().isOrganization;
                      if (_selectedUserType == UserType.organization && !isOrganization) {
                        setState(() {
                          _errorText = "You are not authorized to log in as an organization.";
                        });
                      } else {
                        // Redirect to appropriate home page based on selected user type
                        switch (_selectedUserType) {
                          case UserType.organization:
                            Navigator.pushReplacementNamed(context, '/organization_home');
                            break;
                          default:
                            Navigator.pushReplacementNamed(context, '/donor_home');
                        }
                      }
                    }
                  }
                },
                child: const Text('Login', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                // Add a new button for sign up
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
