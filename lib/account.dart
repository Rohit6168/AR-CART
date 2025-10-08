import 'package:ar_cart/Home.dart';
import 'package:ar_cart/WelcomeScreen.dart';
import 'package:ar_cart/category.dart';
import 'package:ar_cart/notification.dart';
import 'package:ar_cart/Auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Import AwesomeDialog
import 'bottom_navigation.dart';

class account extends StatefulWidget {
  const account({super.key, required user});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  final AuthService _auth = AuthService(); // Create an instance of AuthService
  int _currentIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => notification()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => category(user: widget,)),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => account(user: widget,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5DFD5),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onItemSelected: _onItemTapped, // Pass the callback
      ),
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Color(0xFFF5DFD5),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Edit Profile'),
            leading: Icon(Icons.edit),
            onTap: () {
              // Handle Edit Profile tap
            },
          ),
          ListTile(
            title: Text('Change Password'),
            leading: Icon(Icons.lock),
            onTap: () {
              // Handle Change Password tap
            },
          ),
          ListTile(
            title: Text('Order History'),
            leading: Icon(Icons.history),
            onTap: () {
              // Handle Order History tap
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () async {
              await _auth.signOut();
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'Logout Successful',
                desc: 'You have been logged out successfully!',
                btnOkColor: Color(0xFF130101),
                btnOkOnPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
              ).show();
            },
          ),
        ],
      ),
    );
  }
}
