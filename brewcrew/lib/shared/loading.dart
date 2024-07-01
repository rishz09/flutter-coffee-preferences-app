//ignore_for_file: prefer_const_constructors
import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 215, 204, 200),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50,
        ),
      ),
    );
  }
}

class LoadingInitally extends StatefulWidget {
  const LoadingInitally({super.key});

  @override
  State<LoadingInitally> createState() => _LoadingInitallyState();
}

class _LoadingInitallyState extends State<LoadingInitally> {
  bool showContainer = true;

  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showContainer = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showContainer) {
      return Loading();
    } else {
      return Authenticate();
    }
  }
}
