import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/home/presentation/pages/main_check_list_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Check List App',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.white,
          fontFamily: "Raleway",
          appBarTheme: AppBarTheme(
            color: AppColors.primaryColor,
            elevation: 0,
            titleTextStyle: AppTextStyles.ralewayFont20SemiBold(context)
                .copyWith(color: AppColors.white),
            iconTheme: const IconThemeData(color: AppColors.white),
          ),
        ),
        home: const MainChecklistPage(),
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }
}
