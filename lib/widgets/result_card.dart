import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 3rd party packages
import 'package:provider/provider.dart';

// Own packages
import 'package:xcurrency/state.dart';
import 'package:xcurrency/widgets/busy_indicator.dart';
import 'package:xcurrency/const.dart';

class ResultCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: context.watch<Data>().multiplier != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        APP_PADDING, 0, APP_PADDING, APP_PADDING),
                    child: context.watch<Data>().amount != null
                        ? Text(
                            _getConversionText(
                                context: context,
                                amount: context.watch<Data>().amount ?? 1,
                                round: true),
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen),
                            textAlign: TextAlign.center,
                          )
                        : null,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: APP_PADDING),
                    child: Text(
                      _getConversionText(context: context, amount: 1),
                      style: TextStyle(
                          fontSize: APP_FONT_SIZE, color: Colors.grey[400]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        APP_PADDING, APP_PADDING, APP_PADDING, 0),
                    child: Text(
                      'Rate updated at: ${DateFormat(DATE_FORMAT).format(context.watch<Data>().updatedAt.toLocal())}',
                      style: TextStyle(
                          fontSize: APP_FONT_SIZE_SMALL,
                          color: Colors.grey[400]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'Last checked at: ${DateFormat(DATE_FORMAT).format(context.watch<Data>().lastCheckedAt.toLocal())}',
                    style: TextStyle(
                        fontSize: APP_FONT_SIZE_SMALL, color: Colors.grey[400]),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : BusyIndicator(),
      ),
    );
  }

  String _getConversionText(
      {BuildContext context, double amount, bool round = false}) {
    final String derived = round
        ? (amount * context.watch<Data>().multiplier).toStringAsFixed(2)
        : (amount * context.watch<Data>().multiplier).toString();

    return '$amount ${context.watch<Data>().from} ≈ '
        '$derived '
        '${context.watch<Data>().to}';
  }
}
