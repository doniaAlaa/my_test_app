import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/auth/presentation/screens/splash_screeen.dart';
import 'package:test_app/auth/cubit/auth_cubit.dart';
import 'package:test_app/auth/data/repo/auth_repo.dart';
import 'package:test_app/auth/data/data_source/auth_local_db.dart';
import 'package:test_app/const/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AuthCubit(
        AuthRepo(AuthLocalData()),
      ),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),

        home: SplashScreen(),
      ),
    );
  }
}