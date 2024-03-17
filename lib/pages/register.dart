import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {

  final VoidCallback showLoginPage;
  const RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.primary;

    return Container(
      color: Color.fromARGB(255, 193, 249, 232),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                child: Text(
                  'registering for',
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Text(
                  'WalkNTalk',
                  style: TextStyle(
                    fontSize: 50,
                    color: textColor,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          RegisterBox(showLoginPage: showLoginPage),
          Container(
              padding: const EdgeInsets.fromLTRB(70, 20, 70, 0),
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage('assets/coverImage.jpg')
              ),
          ),
        ],
      ),
    );
  }
}

class RegisterBox extends StatelessWidget {
  final VoidCallback showLoginPage;
  const RegisterBox({
    super.key,
    required this.showLoginPage,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();

    Future addUserDetails() async {
      await FirebaseFirestore.instance.collection('users').add({
        'email': emailController.text.trim(),
        'username': usernameController.text.trim(),
      });
    }

    Future singUp() async {
      if (passwordController.text.trim() != rePasswordController.text.trim()) {
        print('passwords do not match');
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await addUserDetails();
      } on FirebaseAuthException catch (e) {
        print('error: $e');
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          }
        );
      }
    }

    return Material(
      child: Container(
        color: Color.fromARGB(255, 193, 249, 232),
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'E-mail',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 15,),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'Username',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'Password',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: rePasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'Confirm Password',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 233, 177)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.all(Size(90, 40)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                      onPressed: showLoginPage,
                      child: Text('< Back', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary, height: 1)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.all(Size(180, 40)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                      onPressed: () {
                        // Respond to button press
                        print('request create account');
                        singUp();
                      },
                      child: Text('Create Account', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primaryContainer, height: 1)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}