import 'package:cybear_jinni/features/home_page/tabs/routine_tab/add_routine/pick_date_page.dart';
import 'package:cybear_jinni/features/shared_widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The page to add new routines
class AddRoutinePage extends StatelessWidget {
  void backButtonFuntion(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
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
            TopNavigationBar(
              'Add Routine',
              null,
              () {},
              leftIcon: FontAwesomeIcons.arrowLeft,
              leftIconFunction: backButtonFuntion,
            ),
            SizedBox(
              height: 100,
            ),
            Text('When to execute'),
            FlatButton(
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PickDatePage()));
                },
                child: Text('Select')),
            SizedBox(
              height: 30,
            ),
            Text('Only if'),
            FlatButton(
                color: Colors.grey,
                onPressed: () {},
                child: Text(
                  'Select',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 30,
            ),
            Text('Execute this'),
            FlatButton(
                color: Colors.grey, onPressed: () {}, child: Text('Select')),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
