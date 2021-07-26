import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/round_button.dart';

class WelcomeScreen extends StatefulWidget {

  static String welcomeScreenId = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  // AnimationController controller;

  // @override
  // void initState() {
  //   super.initState();
    // controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    //
    //  setState(() { });
    // controller.forward();
    // setState(() {
    //
    // });
    // controller.addListener(() {
    //   print(controller.value);
    // });

  // }


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
            Row(
              children: <Widget>[
                Hero(
                  tag: 'animate',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                DefaultTextStyle(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat')
                    ],
                  ),
                   style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                     color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                buttonTitle: 'Login',
                color: Colors.lightBlueAccent,
                onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.loginScreenId);
              },
            ),
            RoundedButton(
              buttonTitle: 'Register',
              color: Colors.blueAccent,
            onPressed: () {
              //Go to registration screen.
              Navigator.pushNamed(context, RegistrationScreen.registrationScreenId);
            },
          ),
          ],
        ),
      ),
    );
  }
}
