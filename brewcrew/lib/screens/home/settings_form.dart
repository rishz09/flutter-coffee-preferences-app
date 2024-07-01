//ignore_for_file: prefer_const_constructors
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName, _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    //we have access to current logged in user now
    final user = Provider.of<UserCustom?>(context);
    return StreamBuilder<UserData?>(
        //listening to stream inside this widget
        stream: DatabaseService(uid: user!.uid).userData,
        //this snapshot has nothing to do with firebase's snapshot. It just refers to the data received
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Your Brew Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20),

                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  SizedBox(height: 20),
                  //slider
                  Column(
                    children: <Widget>[
                      Text(
                        'Brew Strength',
                        style: TextStyle(fontSize: 15),
                      ),
                      Slider(
                        activeColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        value:
                            (_currentStrength ?? userData.strength).toDouble(),
                        min: 100,
                        max: 900,
                        divisions: 8,
                        onChanged: (val) =>
                            setState(() => _currentStrength = val.round()),
                      ),
                    ],
                  ),
                  //button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
