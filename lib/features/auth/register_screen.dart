import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/main/main_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController comfirmPasswordController = TextEditingController();

  String? errorMessage;

  bool isLoading = false;

  bool isVisible = false;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    final String? error = await UserRepository().signUp(
      email: emailController.text,
      name: userNameController.text,
      password: passwordController.text,
    );
    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }
    await PreferencesManager().setBool("is_logged_in", true);
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MainScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSize.pw16),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/splash.png",
                          height: AppSize.h45,
                        ),
                      ),
                      SizedBox(height: AppSize.ph24),
                      Text(
                        'Welcome to Newts',
                        style: TextStyle(
                          color: const Color(0xFF363636),
                          fontSize: AppSize.sp20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: AppSize.ph24),
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

                      SizedBox(height: AppSize.ph24),
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
                      SizedBox(height: AppSize.ph24),
                      CustomTextFormField(
                        controller: passwordController,
                        hintText: "*************",
                        title: "Password",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.ph24),
                      CustomTextFormField(
                        controller: comfirmPasswordController,
                        hintText: "*************",
                        title: "Confirm Passward",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                      if (errorMessage != null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.ph8),
                          child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                        ),
                      SizedBox(height: AppSize.ph24),
                      SizedBox(
                        width: double.infinity,
                        height: AppSize.h48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              register();
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Sign Up'),
                        ),
                      ),
                      SizedBox(height: AppSize.ph24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account ?",
                            style: TextStyle(fontSize: AppSize.sp14),
                          ),
                          SizedBox(width: AppSize.pw8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: AppSize.sp16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
