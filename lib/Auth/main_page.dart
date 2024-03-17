import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wnt/Auth/auth_page.dart';
import '../pages/home_page.dart';
import '../pages/user_profile.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)  {
          if (snapshot.hasData) {
            return ProfilePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}