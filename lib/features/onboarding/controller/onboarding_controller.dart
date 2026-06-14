import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  int currentIndex = 0;
  bool isLastPage  = false;

  final PageController pageController = PageController();

  void onPageChanged(int index) {
    if(index == 2){
      isLastPage = true;
    }else{
      isLastPage = false;
    }
    currentIndex = index;

    notifyListeners();
  }
}
