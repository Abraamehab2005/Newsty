import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/auth/repo/auth_repository.dart';
import 'package:news_app/features/main/main_screen.dart';

import '../../core/datasource/remote_data/api_service.dart';
import 'cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  bool isVisible = false;


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthCubit(AuthRepository(ApiService())),
  child: Scaffold(
      body: BlocListener< AuthCubit, AuthState>(
  listener: (context, state) {
    if(state.authStatus == RequestStatusEnum.loaded){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
    }
  },
  child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
    return Padding(
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
                      const Text(
                        'Welcome to Newts',
                        style: TextStyle(
                          color: Color(0xFF363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: AppSize.ph24),
                      CustomTextFormField(
                        controller: usernameController,
                        hintText: "ebraam@gmail.com",
                        title: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          // final emailRegex = RegExp(
                          //   r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          // );
                          // if (!emailRegex.hasMatch(value)) {
                          //   return "Enter a valid email address";
                          // } else {
                          //   return null;
                          // }
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
                      if (state.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.ph8),
                          child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
                        ),
                      SizedBox(height: AppSize.ph24),
                      SizedBox(
                        width: double.infinity,
                        height: AppSize.h48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_form.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(username: usernameController.text, password: passwordController.text);
                            }
                          },
                          child: state.authStatus ==RequestStatusEnum.loading
                              ? const CircularProgressIndicator()
                              : const Text('Sign In'),
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
                                    return const RegisterScreen();
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
          );
  },
),
        ),
      ),
),
    ),
);
  }
}
