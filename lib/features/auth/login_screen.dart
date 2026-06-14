import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/images/splash.png", height: 45),
              ),
              SizedBox(height: 24),
              Text(
                'Welcome to Newts',
                style: TextStyle(
                  color: Color(0xFF363636),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: controller,
                hintText: "usama@gmail.com",
                title: "Email",
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: controller,
                hintText: "*************",
                title: "Password",
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: isVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
