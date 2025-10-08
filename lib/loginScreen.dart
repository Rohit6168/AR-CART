import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ar_cart/Auth.dart';
import 'package:ar_cart/account.dart'; 
import 'package:ar_cart/loginuser.dart'; 
import 'package:ar_cart/regScreen.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final AuthService _auth = AuthService(); // Create an instance of AuthService

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF130101), Color.fromARGB(255, 72, 65, 72)]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
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
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 33, 15, 15),
                          ),
                          label: Text(
                            'Gmail',
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
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff281537),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // Perform sign-in action
                            dynamic result = await _auth.signInEmailPassword(
                              LoginUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                            if (result.uid == null) {
                              // Show error message if login fails
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: result.code,
                              ).show();
                            } else {
                              // Show success message and navigate to Home
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Success',
                                desc: 'Login successful!',
                                btnOkColor: Color(0xFF130101),
                                btnOkOnPress: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => account(user: result)), // Pass user information
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
                              Color.fromARGB(255, 72, 65, 72)
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
                                  builder: (context) => const RegScreen()));
                        },
                        child: const Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 88, 87, 87)),
                              ),
                              Text(
                                "Sign up !!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
