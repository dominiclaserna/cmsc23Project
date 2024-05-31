// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/themedata.dart';  // Assuming you have the themedata.dart file

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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController proofsController = TextEditingController();

  String? _passwordErrorText;
  String? _emailErrorText;
  String _userType = 'donor';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: firstNameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "First Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter first name.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: lastNameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Last Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter last name.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Username",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a username.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          errorText: _emailErrorText,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email.";
                          }
                          if (!RegExp(
                                  r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                              .hasMatch(value)) {
                            return "Please enter a valid email address.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          errorText: _passwordErrorText,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password.";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: contactNumberController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Contact Number",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter contact number.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: addressController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Address",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter address.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _userType,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "User Type",
                        ),
                        items: <String>['donor', 'organization']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _userType = newValue!;
                          });
                        },
                      ),
                      if (_userType == 'organization') ...[
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: orgNameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Organization Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter organization name.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: proofsController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Proofs of Legitimacy",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter proofs of legitimacy.";
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Remove previous error text upon clicking the sign-up button again
                            setState(() {
                              _emailErrorText = null;
                              _passwordErrorText = null;
                            });
                            bool isOrganization = false;

                            List<String> addresses = [
                              addressController.text.trim()
                            ];

                            String? result = await context
                                .read<AuthProvider>()
                                .signUp(
                                  emailController.text,
                                  passwordController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  usernameController.text,
                                  contactNumberController.text,
                                  addresses,
                                  _userType,
                                  orgNameController.text,
                                  proofsController.text,
                                  false,
                                );

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
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back',
                            style: TextStyle(color: Color(0xFF02c39a))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
