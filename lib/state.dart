import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Own packages
import 'package:xcurrency/const.dart';
import 'package:xcurrency/models/rate.dart';
import 'package:xcurrency/services/api.dart';

class Data with ChangeNotifier, DiagnosticableTreeMixin {
  double _amount;
  double _multiplier;
  String _from = DEFAULT_CURRENCY_FROM;
  String _to = DEFAULT_CURRENCY_TO;
  List<String> _currencies;
  DateTime _updatedAt = DateTime.now();
  DateTime _lastCheckedAt = DateTime.now();

  double get amount => _amount;
  double get multiplier => _multiplier;
  String get from => _from;
  String get to => _to;
  List<String> get currencies => _currencies;
  DateTime get updatedAt => _updatedAt;
  DateTime get lastCheckedAt => _lastCheckedAt;

  Data() {
    getCurrencies()
        .then((updatedCurrencies) => changeCurrencies(updatedCurrencies));
    getRate(DEFAULT_CURRENCY_FROM, DEFAULT_CURRENCY_TO).then((rate) {
      changeMultiplier(rate.multiplier);
      changeUpdatedAt(rate.updatedAt);
      changeLastCheckedAt(DateTime.now());
    });
  }

  void changeAmount(double updatedAmount) {
    _amount = updatedAmount;
    notifyListeners();
  }

  void changeMultiplier(double updatedMultiplier) {
    _multiplier = updatedMultiplier;
    notifyListeners();
  }

  void changeCurrencies(List<String> updatedCurrencies) {
    _currencies = updatedCurrencies;
    notifyListeners();
  }

  void changeFrom(String updatedFrom) {
    _from = updatedFrom;
    notifyListeners();
  }

  void changeTo(String updatedTo) {
    _to = updatedTo;
    notifyListeners();
  }

  void changeUpdatedAt(DateTime updatedAt) {
    _updatedAt = updatedAt;
    notifyListeners();
  }

  void changeLastCheckedAt(DateTime updatedLastCheckedAt) {
    _lastCheckedAt = updatedLastCheckedAt;
    notifyListeners();
  }

  void changeRate(Rate updatedRate) {
    _multiplier = updatedRate.multiplier;
    _updatedAt = updatedRate.updatedAt;
    _lastCheckedAt = DateTime.now();
    notifyListeners();
  }

  /// Makes props readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('amount', amount));
    properties.add(DoubleProperty('multiplier', multiplier));
    properties.add(StringProperty('from', from));
    properties.add(StringProperty('to', to));
    properties.add(StringProperty('currencies', currencies.toString()));
    properties.add(StringProperty('updatedAt', updatedAt.toString()));
    properties.add(StringProperty('lastCheckedAt', lastCheckedAt.toString()));
  }
}
