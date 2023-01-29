import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool _isTriggerHome = false;

  bool get isTriggerHome => _isTriggerHome;

  void startAnimationHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isTriggerHome = true;
      notifyListeners();
    });
  }
}
