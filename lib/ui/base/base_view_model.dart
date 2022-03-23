import 'package:flutter/cupertino.dart';

class BaseViewModel with ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  void setBusy(bool busyState) {
    _isBusy = busyState;
    notifyListeners();
  }
}
