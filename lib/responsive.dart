import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget webLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.webLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          // Mobile layout
          return mobileLayout;
        } else if (constraints.maxWidth < 1100) {
          // Tablet layout
          return tabletLayout;
        } else {
          // Web layout
          return webLayout;
        }
      },
    );
  }
}