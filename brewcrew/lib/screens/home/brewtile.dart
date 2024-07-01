//ignore_for_file: prefer_const_constructors
import 'package:brewcrew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/shared/constants.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({required this.brew});
  @override
  Widget build(BuildContext context) {
    /*return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            //strength of brown still can be seen because middle of image is transparent
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );*/
    final user = Provider.of<UserCustom?>(context);
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: 8),
            child: Card(
              shape: user.uid == brew.uid ? borderForCurrentUser : null,
              margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/coffee_icon.png'),
                  //strength of brown still can be seen because middle of image is transparent
                  radius: 25,
                  backgroundColor: Colors.brown[brew.strength],
                ),
                title: Text(brew.name),
                subtitle: Text('Takes ${brew.sugars} sugar(s)'),
              ),
            ),
          );
        });
  }
}
