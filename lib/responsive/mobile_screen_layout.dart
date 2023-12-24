import 'package:flutter/material.dart';
import 'package:instagram_app_flutter/providers/user_provider.dart';
import 'package:instagram_app_flutter/models/user.dart' as model;
import 'package:instagram_app_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: user == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Text(user.username),
      ),
    );
  }
}
