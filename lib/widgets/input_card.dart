import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:provider/provider.dart';

// Own packages
import 'package:xcurrency/widgets/symbol_list.dart';
import 'package:xcurrency/state.dart';
import 'package:xcurrency/services/api.dart';
import 'package:xcurrency/const.dart';
import 'package:xcurrency/helpers/regex_formatter.dart';
import 'package:xcurrency/widgets/busy_indicator.dart';

class InputCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: context.watch<Data>().currencies != null
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(APP_PADDING),
                    child: TextField(
                      style: TextStyle(fontSize: APP_FONT_SIZE),
                      inputFormatters: [
                        RegExInputFormatter.withRegex(AMOUNT_FORMAT)
                      ],
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:
                            'Convert ${context.watch<Data>().from} > ${context.watch<Data>().to}',
                        hintText: '${context.watch<Data>().from}',
                        hintStyle: TextStyle(color: Colors.grey[350]),
                        prefixIcon: const Icon(Icons.monetization_on),
                      ),
                      onChanged: (String updatedAmount) =>
                          EasyDebounce.debounce(
                              'amount-onChanged',
                              Duration(milliseconds: ON_CHANGE_DEBOUNCE_TIME),
                              () => _updateAmount(
                                  context: context,
                                  updatedAmount:
                                      updatedAmount) // <-- The target method
                              ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(APP_PADDING),
                          child: SymbolList(
                            value: () => '${context.watch<Data>().from}',
                            onChanged: (updatedFrom) async {
                              context.read<Data>().changeFrom(updatedFrom);
                              context.read<Data>().changeRate(await getRate(
                                  updatedFrom, context.read<Data>().to));
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.compare_arrows, size: 34),
                          onPressed: () => _invertCurrencies(context: context)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(APP_PADDING),
                          child: SymbolList(
                              value: () => '${context.watch<Data>().to}',
                              onChanged: (updatedTo) async {
                                context.read<Data>().changeTo(updatedTo);
                                context.read<Data>().changeRate(await getRate(
                                    context.read<Data>().from, updatedTo));
                              }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(APP_PADDING),
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(APP_PADDING_HALF),
                            child:
                                Icon(Icons.sync, color: Colors.white, size: 30),
                          ),
                          Text(
                            'Update rate',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: APP_FONT_SIZE),
                          ),
                        ],
                      ),
                      color: Colors.lightGreen,
                      onPressed: context.read<Data>().amount != null
                          ? () async => context.read<Data>().changeRate(
                              await getRate(context.read<Data>().from,
                                  context.read<Data>().to))
                          : null,
                    ),
                  ),
                ],
              )
            : SizedBox(height: 250, child: BusyIndicator()));
  }

  void _updateAmount({BuildContext context, String updatedAmount}) async {
    final double prevAmount = context.read<Data>().amount;

    if (updatedAmount == '') {
      context.read<Data>().changeAmount(null);
      return;
    }

    final parsedUpdatedAmount = double.parse(updatedAmount);
    if (parsedUpdatedAmount == prevAmount) {
      return;
    }
    context.read<Data>().changeAmount(parsedUpdatedAmount);
  }

  void _invertCurrencies({BuildContext context}) async {
    final copyFrom = context.read<Data>().from;
    context.read<Data>().changeFrom(context.read<Data>().to);
    context.read<Data>().changeTo(copyFrom);
    context
        .read<Data>()
        .changeRate(await getRate(context.read<Data>().from, copyFrom));
  }
}
