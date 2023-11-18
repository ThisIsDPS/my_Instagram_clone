import 'package:flutter/material.dart';
import 'package:instagram_app_flutter/utils/dimesions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // LayoutBuilder ~ Helps in creating responsive layouts
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenWidthSize) {
          // Web Screen Layout
          return webScreenLayout;
        } 
        // Mobile Screen Layout
        return mobileScreenLayout;
      },
    );
  }
}
