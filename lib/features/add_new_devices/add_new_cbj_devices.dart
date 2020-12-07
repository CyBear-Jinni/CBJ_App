import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

/// This page will show all the CyBear Jinni devices that have connected to the
/// hotspot of the app device.
class AddNewCBJDevices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddNewCBJDevices();
  }
}

class _AddNewCBJDevices extends State<AddNewCBJDevices>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: const <double>[0, 0, 0, 1],
            colors: <Color>[
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft,
                    color: Theme.of(context).textTheme.bodyText1.color),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              'CyBear Jinni New Devices',
              style: TextStyle(
                  fontSize: 23.0,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  decoration: TextDecoration.underline),
            ).tr(),
            const SizedBox(height: 50,),
            const Text("Can't find any devices", style: TextStyle(
                fontSize: 15.0,),),
          ],
        ),
      ),
    );
  }

}