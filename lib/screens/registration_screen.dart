import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {

  static String registrationScreenId = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag : 'register',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Please Enter an Email',
                  hintStyle: TextStyle(
                      color: Colors.black87
                  )
              )
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Please Enter a Password',
                  hintStyle: TextStyle(
                      color: Colors.black87
                  )
              )
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(buttonTitle: 'Register', color: Colors.blueAccent,onPressed: () async {
              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                try{
                  if(newUser != null){
                    Navigator.pushNamed(context, ChatScreen.chatScreenId);
                  }
                }catch(e){
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
