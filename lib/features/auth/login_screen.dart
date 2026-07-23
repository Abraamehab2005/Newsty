import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  bool isVisible = false;
  bool isLoading = false;
  String? errorMessage;
  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PreferencesManager().getString("user_email");
    final savedPassword = PreferencesManager().getString("user_password");
    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = "No Account Please Register First";
        isLoading = false;
      });
      return;
    }
    if (savedEmail != emailController.text || savedPassword != passwordController.text) {
      setState(() {
        errorMessage = "Incorrect Email or Passsword";
        isLoading = false;
      });
      return;
    }

    await PreferencesManager().setBool("is_logged_in", true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );
    setState(() {
      errorMessage = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSize.pw16),
            child: Form(
              key: _form,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
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
                          color: Color(0xFF363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: AppSize.ph24),
                      CustomTextFormField(
                        controller: emailController,
                        hintText: "ebraam@gmail.com",
                        title: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email address";
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
                      if (errorMessage != null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.ph8),
                          child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
                        ),
                      SizedBox(height: AppSize.ph24),
                      SizedBox(
                        width: double.infinity,
                        height: AppSize.h48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_form.currentState?.validate() ?? false) {
                              login();
                            }
                          },
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text('Sign In'),
                        ),
                      ),
                      SizedBox(height: AppSize.ph24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account ?",
                            style: TextStyle(fontSize: AppSize.sp14),
                          ),
                          SizedBox(width: AppSize.pw8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return RegisterScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
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
