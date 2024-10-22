import 'package:checklist_app/cubit/app_cubit.dart';
import 'package:checklist_app/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: ResponsiveBreakpoints.builder(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Check List App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeView(),
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
