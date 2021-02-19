import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:provider/provider.dart';

// Own packages
import 'package:xcurrency/const.dart';
import 'package:xcurrency/state.dart';

class SymbolList extends StatelessWidget {
  final Function value;
  final Function onChanged;

  SymbolList({
    @required this.value,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> symbols = context.watch<Data>().currencies;
    return DropdownButton<String>(
      value: '${value()}',
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 34,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: APP_FONT_SIZE),
      underline: Container(
        height: 2,
        color: Colors.lightGreen,
      ),
      onChanged: onChanged,
      items: symbols.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
