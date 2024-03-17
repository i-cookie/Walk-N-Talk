import 'package:flutter/material.dart';
import 'forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatelessWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({
    super.key,
    required this.showRegisterPage,
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
                  'welcome to',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Start making friends...',
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          LoginBox(showRegisterPage: showRegisterPage),
          Container(
              padding: const EdgeInsets.fromLTRB(70, 20, 70, 0),
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage('assets/coverImage.jpg')
              ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class LoginBox extends StatelessWidget {
  final VoidCallback showRegisterPage;
  const LoginBox({
    super.key,
    required this.showRegisterPage,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future signIn() async{
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), 
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        print(e.toString());
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
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'Email',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'Password',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.all(Size(70, 40)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                      onPressed: () {
                        // submit data in the text fields
                        print('request login');
                        signIn();
                        // submitLoginInfo(usernameController.text, passwordController.text);
                      },
                      child: Text('Login', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primaryContainer, height: 1)),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 233, 177)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.all(Size(100, 40)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                      onPressed: showRegisterPage,
                      child: Text('Register', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary, height: 1)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 233, 177)),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    fixedSize: MaterialStateProperty.all(Size(180, 40)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                  onPressed: () {
                    // Respond to button press
                    print('request password retrieval');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
                  },
                  child: Text('Forgot Password', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary, height: 1)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}