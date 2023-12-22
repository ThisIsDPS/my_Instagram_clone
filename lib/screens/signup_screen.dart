import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app_flutter/resources/auth_methods.dart';
import 'package:instagram_app_flutter/utils/colors.dart';
import 'package:instagram_app_flutter/utils/utils.dart';
import 'package:instagram_app_flutter/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Conntrollers for email, bio, username & password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  // Profile picture image storing in global variable 
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _passowordController.dispose();
  }

  // 'selectImage' function using 'image_picker' package
  void selectImage() async {
    // 'pickImage' class is defined in 'utils/utils/dart'
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
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
              // Circular widget to accept & show our selected file
              Stack(
                children: [
                  // Setting profile pic image
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'),
                        ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              // Text Field Input for Username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
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
              // Text Field Input for Bio
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // Button for Login using Container widget
              InkWell(
                onTap: () async {
                  String result = await AuthMethods().signUpUser(
                    email: _emailController.text,
                    password: _passowordController.text,
                    username: _usernameController.text,
                    bio: _bioController.text,
                    file: _image!,
                  );
                  print(result);
                },
                child: Container(
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
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 1,
                child: Container(),
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
