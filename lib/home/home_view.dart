import 'package:checklist_app/core/custom_widgets/responsive_layout.dart';
import 'package:checklist_app/home/mobile_host_check_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileLayout: (context) => const MobileHostCheckList(),
        tabletLayout: (context) => const SizedBox.shrink(),
        desktopLayout: (context) => const MobileHostCheckList(),
      ),
    );
  }
}
