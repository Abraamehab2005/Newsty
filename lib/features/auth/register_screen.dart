import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/repo/auth_repository.dart';
import 'package:news_app/features/main/main_screen.dart';

import '../../core/datasource/remote_data/api_service.dart';
import '../../core/enums/request_status_enum.dart';
import 'login_screen.dart';
class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
  create: (context) => AuthCubit(AuthRepository(ApiService())),
  child: Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>
          (listener: (context, state) {
            if(state.authStatus == RequestStatusEnum.loaded){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                return const MainScreen();
              }));
            }
     },
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
            child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
            return Form(
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
                        controller: confirmPasswordController,
                        hintText: "*************",
                        title: "Confirm Password",
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
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().register(name: userNameController.text , email: emailController.text , password: passwordController.text);
                            }
                          },
                          child: state.authStatus ==RequestStatusEnum.loading
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
            );
  },
),
          ),
        ),
),
      ),
    ),
);
  }
}
