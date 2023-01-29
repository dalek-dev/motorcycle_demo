import 'package:flutter/material.dart';

class DescriptionProvider with ChangeNotifier {
  bool _isTriggerDescription = false;

  bool get isTriggerDescription => _isTriggerDescription;

  void startAnimationDescription() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isTriggerDescription = true;
      notifyListeners();
    });
  }
}
