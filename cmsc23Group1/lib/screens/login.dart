// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/themedata.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
    return Theme(
      data: appTheme,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Elbi Cares',
                  style: TextStyle(
                    fontSize: 65,
                    fontFamily: 'Roboto',
                    color: Color(0xFF05668d),
                  ),
                ),
                const SizedBox(height: 50),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: appTheme.cardColor,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<UserType>(
                            value: _selectedUserType,
                            onChanged: (value) {
                              setState(() {
                                _selectedUserType = value!;
                              });
                            },
                            items: UserType.values.map((UserType userType) {
                              return DropdownMenuItem<UserType>(
                                value: userType,
                                child: Text(userType
                                    .toString()
                                    .split('.')
                                    .last
                                    .toUpperCase()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Select User Type',
                              border: appTheme.inputDecorationTheme.border,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email",
                              errorText: _errorText,
                              border: appTheme.inputDecorationTheme.border,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email.";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              errorText: _errorText,
                              border: appTheme.inputDecorationTheme.border,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password.";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _errorText = null;
                                    });

                                    String? result = await context
                                        .read<AuthProvider>()
                                        .signIn(emailController.text,
                                            passwordController.text);

                                    if (result != null) {
                                      setState(() {
                                        _errorText =
                                            "Invalid email or password.";
                                      });
                                    } else {
                                      // Check if the entered email is admin
                                      if (emailController.text ==
                                          'admin@yahoo.com') {
                                        Navigator.pushReplacementNamed(
                                            context, '/admin_home');
                                        return;
                                      }

                                      // Check if the user is allowed to log in as an organization
                                      bool isOrganization = context
                                          .read<AuthProvider>()
                                          .isOrganization;

                                      if (_selectedUserType ==
                                              UserType.organization &&
                                          !isOrganization) {
                                        setState(() {
                                          _errorText =
                                              "You are not authorized to log in as an organization.";
                                        });
                                      } else {
                                        // Redirect to appropriate home page based on selected user type
                                        switch (_selectedUserType) {
                                          case UserType.organization:
                                            Navigator.pushReplacementNamed(
                                                context, '/organization_home');
                                            break;
                                          default:
                                            Navigator.pushReplacementNamed(
                                                context, '/donor_home');
                                        }
                                      }
                                    }
                                  }
                                },
                                child: const Text('Login',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                // Add a new button for sign up
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage()));
                                },
                                child: const Text('Sign Up',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
