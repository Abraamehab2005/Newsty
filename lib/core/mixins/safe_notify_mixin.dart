import 'package:flutter/material.dart';

mixin SafeNotifyMixin on ChangeNotifier{
  bool isDispose = false;
  safeNotify() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}