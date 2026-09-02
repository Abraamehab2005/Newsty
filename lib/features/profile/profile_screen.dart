import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/bottom_sheet/profile_info_bottom_sheet.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) {
        return ProfileCubit()..getUserDate();
      },
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Profile")),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSize.h24, horizontal: AppSize.w16),
          child: BlocBuilder<ProfileCubit , ProfileState>(
            builder: (BuildContext context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: state.selectedImage == null
                                ? const AssetImage("assets/images/person.png")
                                : FileImage(File(state.selectedImage!.path)),
                            radius: AppSize.r60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () {
                              showImageSourceDialog(context);
                            },
                            child: Container(
                              height: AppSize.h45,
                              width: AppSize.w45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(AppSize.r20),
                              ),
                              child: const Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.ph8),
                    Center(
                      child: Text(
                       state.userName ?? "",
                        style: TextStyle(color: Colors.black, fontSize: AppSize.sp12),
                      ),
                    ),
                    SizedBox(height: AppSize.ph16),
                    _buildProfileItem("Personal Item", "assets/images/profile.svg", () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return const ProfileInfoBottomSheet();
                        },
                      ).then((value) {
                        context.read<ProfileCubit>().getUserDate();
                      });
                    }),
                    _buildProfileItem("Language", "assets/images/language.svg", () {}),
                    _buildProfileItem(state.countryName ??  "Country", "assets/images/country.svg", () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          context.read<ProfileCubit>().saveCountry(country);
                        },
                      );
                    }),
                    _buildProfileItem(
                      "Terms & Conditions",
                      "assets/images/term_condition.svg",
                      () {},
                    ),
                    _buildProfileItem(
                      "Logout",
                      "assets/images/logout.svg",
                      color: LightColors.primaryColor,
                      withDivider: false,
                      () async {
                        // Clear user data from Hive
                        await UserRepository().delete();
                        // Clear user data from SharedPreferences
                        await PreferencesManager().clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context) {
  final controller = context.read<ProfileCubit>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          "Select Image Source",
          style: TextStyle(fontSize: AppSize.h16, color: Colors.black),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
            padding: EdgeInsets.all(AppSize.pw16),
            child: Row(
              children: [
                const Icon(Icons.camera_alt),
                SizedBox(width: AppSize.pw8),
                const Text("Camera"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
            padding: EdgeInsets.all(AppSize.pw16),
            child: Row(
              children: [
                const Icon(Icons.photo_library),
                SizedBox(width: AppSize.pw8),
                const Text("Gellery"),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildProfileItem(
  String title,
  String path,
  Function onTap, {
  Color color = const Color(0xFF161F1B),
  bool withDivider = true,
}) {
  return Column(
    children: [
      ListTile(
        onTap: () => onTap(),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: AppSize.sp16,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: CustomSvgPicture.withoutColor(path: path),
        trailing: CustomSvgPicture.withoutColor(
          path: "assets/images/arrow.svg",
          hight: AppSize.h16,
          width: AppSize.w16,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppSize.pw8),
      ),
      if (withDivider) Divider(color: Colors.grey.shade500),
    ],
  );
}
