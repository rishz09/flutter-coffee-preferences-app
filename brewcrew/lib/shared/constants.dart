//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  //hintText: 'Email',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2),
  ),
);

final ShapeBorder borderForCurrentUser = RoundedRectangleBorder(
    side: BorderSide(color: Color.fromARGB(255, 62, 39, 35), width: 2.0),
    borderRadius: BorderRadius.circular(10));
