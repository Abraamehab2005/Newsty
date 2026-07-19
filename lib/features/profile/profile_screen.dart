import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) {
        return ProfileController();
      },
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Profile")),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.h24,
              horizontal: AppSize.w16,
            ),
            child: Consumer<ProfileController>(
              builder:
                  (
                    BuildContext context,
                    ProfileController controller,
                    Widget? child,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    controller.selectedImage == null
                                    ? AssetImage("assets/images/person.png")
                                    : FileImage(
                                        File(controller.selectedImage!.path),
                                      ),
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
                                    borderRadius: BorderRadius.circular(
                                      AppSize.r20,
                                    ),
                                  ),
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSize.ph8),
                        Center(
                          child: Text(
                            PreferencesManager().getString("user_email") ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppSize.sp12,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.ph16),
                        _buildProfileItem(
                          "Personal Item",
                          "assets/images/profile.svg",
                          () {},
                        ),
                        _buildProfileItem(
                          "Language",
                          "assets/images/language.svg",
                          () {},
                        ),
                        _buildProfileItem(
                          "Country",
                          "assets/images/country.svg",
                          () {},
                        ),
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
                            await PreferencesManager().clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
            ),
          ),
        ),
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context) {
  final controller = context.read<ProfileController>();
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
                Icon(Icons.camera_alt),
                SizedBox(width: AppSize.pw8),
                Text("Camera"),
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
                Icon(Icons.photo_library),
                SizedBox(width: AppSize.pw8),
                Text("Gellery"),
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
