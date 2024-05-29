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
                controller: firstNameController,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
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
                controller: lastNameController,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
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
                controller: usernameController,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a username.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
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
              TextFormField(
                controller: passwordController,
                obscureText: true,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
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
              TextFormField(
                controller: contactNumberController,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
                decoration: const InputDecoration(
                  hintText: "Contact Number",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter contact number.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                style:
                    TextStyle(color: Colors.black), // Set text color to black
                decoration: const InputDecoration(
                  hintText: "Address",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter address.";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _userType,
                decoration: const InputDecoration(
                  hintText: "User Type",
                ),
                items: <String>['donor', 'organization'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _userType = newValue!;
                  });
                },
              ),
              if (_userType == 'organization')
                Column(
                  children: [
                    TextFormField(
                      controller: orgNameController,
                      style: TextStyle(
                          color: Colors.black), // Set text color to black
                      decoration: const InputDecoration(
                        hintText: "Organization Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter organization name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: proofsController,
                      style: TextStyle(
                          color: Colors.black), // Set text color to black
                      decoration: const InputDecoration(
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
                ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Remove previous error text upon clicking the sign-up button again
                    setState(() {
                      _emailErrorText = null;
                      _passwordErrorText = null;
                    });
                    bool isOrganization = false;

                    List<String> addresses = [addressController.text.trim()];

                    String? result = await context.read<AuthProvider>().signUp(
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
