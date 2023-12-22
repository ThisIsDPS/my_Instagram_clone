import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app_flutter/utils/colors.dart';
import 'package:instagram_app_flutter/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Conntrollers for email & password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passowordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea ~ To avoid the system navbar
      body: SafeArea(
        // Conatiner ~ To set padding & width of app
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // To center children horizontally
            children: [
              // Flexible ~ Dynamic Spacing
              Flexible(
                child: Container(),
                flex: 1,
              ),
              // SVG Image (Get the package 'flutter_svg' first)
              SvgPicture.asset(
                'lib/assets/insta_logo.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              // Text Field Input for Email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              // Text Field Input for Password
              TextFieldInput(
                textEditingController: _passowordController,
                hintText: 'Enter you password',
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // Button for Login using Container widget
              InkWell(
                child: Container(
                  child: const Text('Login'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              // Transitioning to Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
