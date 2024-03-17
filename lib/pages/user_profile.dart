import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    TextEditingController usernameController = TextEditingController();
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    String userId = "";

    Future getUserName() async {
      print('getting user name');
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email!)
          .get();
      usernameController.text = userData.docs[0]['username'];
      userId = userData.docs[0].id;
    }

    Future updateUserProfile() async {
      final user = FirebaseAuth.instance.currentUser;
      // validate before update password
      if (currentPasswordController.text.isNotEmpty && usernameController.text.isNotEmpty) {
        final credential = EmailAuthProvider.credential(email: user!.email!, password: currentPasswordController.text);
        bool flag = false;
        try {
          await user.reauthenticateWithCredential(credential);
          flag = false;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            print('The password provided is incorrect.');
            flag = true;
          } else if (e.code == 'user-mismatch') {
            print('The credentials do not match an existing user.');
            flag = true;
          }
        }
        print('flag: $flag');
        if (!flag) {
          print('updating profile');
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'username': usernameController.text,
          });
          if (newPasswordController.text.isNotEmpty) {
            await user.updatePassword(newPasswordController.text);
          }
        }
      }
    }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Color.fromARGB(255, 193, 249, 232),
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              controller: currentPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'Current Password',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: newPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                labelText: 'New Password (empty if not changing)',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    fixedSize: MaterialStateProperty.all(Size(200, 40)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                  onPressed: () {
                    updateUserProfile();
                    // Navigator.pop(context);
                  },
                  child: Text('Update Profile', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primaryContainer, height: 1)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 233, 177)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                fixedSize: MaterialStateProperty.all(Size(180, 40)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              onPressed: () {
                // Respond to button press
                print('cancel update profile');
                FirebaseAuth.instance.signOut();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary, height: 1)),
            ),
          ],
        ),
      ),
    );
  }
}

