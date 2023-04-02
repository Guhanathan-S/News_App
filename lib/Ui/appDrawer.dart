import 'package:flutter/material.dart';
import 'package:news_app/auth.dart';

class Kdrawer extends StatefulWidget {
  final String? displayUserName, displayUserPhoto;
  final Function(bool)? find;
  Kdrawer(
      {@required this.displayUserName,
      @required this.displayUserPhoto,
      @required this.find});
  @override
  _KdrawerState createState() => _KdrawerState();
}

class _KdrawerState extends State<Kdrawer> {
  int count = 0;
  void signOut() {
    signOutGoogleAccount();
  }

  @override
  void initState() {
    widget.find!(true);
    super.initState();
  }

  @override
  void deactivate() {
    widget.find!(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(
                border: Border(bottom: Divider.createBorderSide(context))),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 60,
                  backgroundImage: NetworkImage(widget.displayUserPhoto!),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(text: "Hi,\n"),
                  TextSpan(text: widget.displayUserName)
                ]))
              ],
            ),
          ),
          Kcard(
              text: "Settings",
              icons: Icons.settings,
              onPress: () => print("settings is tapped")),
          Kcard(
              text: "About",
              icons: Icons.announcement_outlined,
              onPress: () => print("About is tapped")),
          Kcard(
              text: "Logout",
              icons: Icons.logout,
              onPress: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Are you sure"),
                        content: const Text("Do you want to logout"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("No"),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 3),
                              signOut()
                            },
                            child: const Text("Yes"),
                          )
                        ],
                      );
                    },
                  )),
        ]),
      ),
    );
  }
}

class Kcard extends StatelessWidget {
  final text, onPress, icons;
  Kcard({this.text, this.onPress, this.icons});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icons),
      title: Text(
        text,
        style: TextStyle(),
      ),
      onTap: onPress,
    );
  }
}
