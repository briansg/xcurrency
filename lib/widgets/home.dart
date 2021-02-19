import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:provider/provider.dart';

// Own packages
import 'package:xcurrency/const.dart';
import 'package:xcurrency/widgets/result_card.dart';
import 'package:xcurrency/widgets/input_card.dart';
import 'package:xcurrency/state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Data(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(APP_NAME),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(APP_PADDING_HALF),
            child: Column(
              children: <Widget>[
                InputCard(),
                ResultCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
