import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadUserDate();
  }

  void _loadUserDate() {
    final UserModel user = UserRepository().getUser();
    userNameController.text = user.name ?? "";
    emailController.text = user.email ?? "";
  }

  void _saveUserDate() async {
    if (_key.currentState?.validate() ?? false) {
      await UserRepository().updateUser(
        name: userNameController.text,
        email: emailController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.r16),
          topRight: Radius.circular(AppSize.r16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: AppSize.h4,
                  width: AppSize.w42,
                  decoration: BoxDecoration(
                    color: Color(0xFF363636),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: AppSize.ph16),
              Text(
                "Profile Info",
                style: TextStyle(
                  color: Color(0xFF141414),
                  fontSize: AppSize.sp16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: AppSize.ph16),
              CustomTextFormField(
                controller: userNameController,
                hintText: "Ebraam Ehab",
                title: "User Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter User Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.ph16),
              CustomTextFormField(
                controller: emailController,
                hintText: "ebraam@gmail.com",
                title: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Email";
                  }
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _saveUserDate();
                },
                child: Text("Save"),
              ),
              SizedBox(height: AppSize.ph16),
            ],
          ),
        ),
      ),
    );
  }
}
