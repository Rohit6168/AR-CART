import 'package:awesome_dialog/awesome_dialog.dart'; 
import 'package:ar_cart/Auth.dart'; 
import 'package:ar_cart/loginScreen.dart';
import 'package:ar_cart/loginuser.dart'; 
import 'package:flutter/material.dart';

class RegScreen extends StatelessWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final AuthService _auth =
        AuthService(); 

    return Scaffold(
      body: Stack(
          //thanks for watching
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF130101),
                  Color.fromARGB(255, 72, 65, 72)
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Color(0xFFF5DFD5),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 33, 15, 15),
                            ),
                            label: Text(
                              'Full Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF130101),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 33, 15, 15),
                            ),
                            label: Text(
                              'Phone or Gmail',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF130101),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Color.fromARGB(255, 33, 15, 15),
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF130101),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Color.fromARGB(255, 33, 15, 15),
                            ),
                            label: Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF130101),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // Perform registration action
                              dynamic result =
                                  await _auth.registerEmailPassword(
                                LoginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                              if (result.uid == null) {
                                // Show error message if registration fails
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: result.code,
                                ).show();
                              } else {
                                // Show success message and navigate to Login
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Success',
                                  desc: 'Registration successful!',
                                  btnOkColor: Color.fromARGB(255, 38, 4, 4),
                                  btnCancelColor: Colors.red,
                                  btnOkOnPress: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => loginScreen()),
                                    );
                                  },
                                ).show();
                              }
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0xFF130101),
                                Color.fromARGB(255, 48, 37, 36),
                              ]),
                            ),
                            child: const Center(
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const loginScreen()));
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 88, 87, 87)),
                                  ),
                                  Text(
                                    "Sign in !!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
