import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusyIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Container(child: CircularProgressIndicator(), width: 32, height: 32),
    );
  }
}
