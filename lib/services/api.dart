import 'dart:convert';

// 3rd party packages
import 'package:http/http.dart' as http;

// Own packages
import 'package:xcurrency/const.dart';
import 'package:xcurrency/models/rate.dart';

Future<List<String>> getCurrencies() async {
  final res = await http.get('$BASE_URL/latest');

  if (res.statusCode != 200) {
    throw Exception(ERR_CURRENCY_GET);
  }

  dynamic jsonRes;
  try {
    jsonRes = jsonDecode(res.body);
  } catch (err) {
    throw Exception(ERR_CURRENCY_PARSE);
  }
  final List<String> currencies = new List();
  for (final currency in jsonRes['rates'].keys) {
    currencies.add(currency);
  }
  currencies.add(jsonRes['base']);
  currencies.sort();

  return currencies;
}

Future<Rate> getRate(from, to) async {
  final res = await http.get('$BASE_URL/latest?base=$from&symbols=$to');

  if (res.statusCode != 200) {
    throw Exception(ERR_CONVERSION_RATE_GET);
  }

  dynamic jsonRes;
  try {
    jsonRes = jsonDecode(res.body);
  } catch (err) {
    throw Exception(ERR_CONVERSION_RATE_PARSE);
  }

  final multiplier = jsonRes['rates'][to];
  if (multiplier == null) {
    throw Exception('$ERR_CONVERSION_RATE_TO $to');
  }

  return Rate.fromJson(jsonRes);
}