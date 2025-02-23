import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/components/authentication/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(2, 0, 36, 1),
                  Color.fromRGBO(47, 59, 163, 1),
                  Color.fromRGBO(18, 125, 147, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 50,
                  ),
                  transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal[700],
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black45,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'My Store',
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontFamily: 'Anton',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AuthForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
