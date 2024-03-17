import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    final theme = Theme.of(context);
    final textColor = theme.colorScheme.primary;

    Future passwordReset() async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Password reset email sent.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          });
      } on FirebaseAuthException catch (e) {
        print('No user found for that email.');
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
                  'Reset your password for',
                  style: TextStyle(
                    fontSize: 20,
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
          Material(
            child: Container(
              color: Color.fromARGB(255, 193, 249, 232),
              padding: const EdgeInsets.fromLTRB(30, 130, 30, 0),
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
                SizedBox(height: 30),
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
                      onPressed: () => Navigator.pop(context),
                      child: Text('< Back', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary, height: 1)),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 233, 177)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.all(Size(180, 40)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                      onPressed: () {
                        // Respond to button press
                        print('Send Reset Email');
                        passwordReset();
                      },
                      child: Text('Send Reset Email', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary, height: 1)),
                    ),
                  ],
                ),
              ],
            ),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(70, 100, 70, 0),
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