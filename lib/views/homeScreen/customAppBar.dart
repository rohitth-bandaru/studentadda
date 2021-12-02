import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentadda/services/authentication_service.dart';
import 'package:studentadda/views/homeScreen/dropDown.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String image;
  final String name;

  const CustomAppBar({Key? key, required this.image, required this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GoogleSignInProvider>(
        builder: (context, googleSignIn, _) => Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomDropDown(),
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(image)),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Text(
                                "Are you sure you want to logout from the App ?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  googleSignIn.logOut();
                                },
                              ),
                              TextButton(
                                child: new Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.logout_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
