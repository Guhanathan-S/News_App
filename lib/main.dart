import 'package:flutter/material.dart';
import 'package:news_app/ui/ui.dart';
import 'package:news_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/auth.dart';
import 'package:firebase_core/firebase_core.dart';

User? users;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => runApp(Login()));
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kThemes,
      debugShowCheckedModeBanner: false,
      home: users == null ? Body() : Home(firebaseUser: users!),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void changepage() {
    signInWithGoogle().then((user) => {
          users = user,
          print(users!.displayName),
          if (users == null)
            {print('null user')}
          else
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                            firebaseUser: users!,
                          )))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: kAppBar,
      body: Align(
        alignment: AlignmentDirectional.center,
        child: OutlinedButton(
          onPressed: changepage,
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45)),
              disabledForegroundColor: Colors.blue),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Image(
                  image: AssetImage('assets/googleicon.png'),
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Sign with Google",
                    style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
