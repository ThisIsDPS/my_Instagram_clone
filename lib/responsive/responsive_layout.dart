import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram_app_flutter/providers/user_provider.dart';
import 'package:instagram_app_flutter/utils/global_variables.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // LayoutBuilder ~ Helps in creating responsive layouts
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenWidthSize) {
          // Web Screen Layout
          return widget.webScreenLayout;
        }
        // Mobile Screen Layout
        return widget.mobileScreenLayout;
      },
    );
  }
}
