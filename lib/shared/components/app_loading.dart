import 'package:fast_location/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.appPageBackground,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.appPageBackground,
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(156, 39, 176, 1)),
        ),
      ),
    );
  }
}