import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:image_picker/image_picker.dart';

import '../../../core/datasource/local_data/user_repository.dart';
import '../../../core/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void pickImage(ImageSource source) async {
    emit(state.copyWith(
      selectedImage: await ImagePicker().pickImage(source: source),
    ));
  }

  void getUserDate() {
    final UserModel? user = UserRepository().getUser();
    emit(state.copyWith(
      userName: user?.name ?? "",
      countryName: user?.countryName,
      countryCode: user?.countryCode,
    ));
  }
  void saveCountry(Country selectedCountry) async{
    await UserRepository().updateUser(
        countryName: selectedCountry.name,
        countryCode: selectedCountry.countryCode
    );
    emit(state.copyWith(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    ));
  }
}
