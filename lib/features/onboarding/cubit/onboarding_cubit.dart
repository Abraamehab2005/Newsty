
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;


part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());
  final PageController pageController = PageController();
  void onPageChanged(int index) {
    if(index == 2){
      emit(state.copyWith(
        currentIndex: index,
        isLastPage: true,
      ));
    }else{
      emit(state.copyWith(
        currentIndex: index,
        isLastPage: false,
      ));
    }
  }
}
