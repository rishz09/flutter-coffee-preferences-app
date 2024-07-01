//ignore_for_file: prefer_const_constructors
import 'package:brewcrew/screens/home/home.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //everytime user logs in, we get a user object back from the stream
    //for logging out, we get null
    final user = Provider.of<UserCustom?>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return LoadingInitally();
    } else {
      return Home();
    }
  }
}
