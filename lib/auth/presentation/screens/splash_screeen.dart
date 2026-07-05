import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app/auth/presentation/screens/login_screen.dart';
import 'package:test_app/const/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  double opacity = 0;

  @override
  void initState() {
    super.initState();

    /// 🎬 Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    /// 🔥 Zoom Animation
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    /// Fade Animation
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          opacity = 1;
        });
      }
    });

    /// ✅ Navigation بعد ما الفريم يترسم
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  void _navigate() {
    Future.delayed(const Duration(seconds:1 ), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>  LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: opacity,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/logo.jpeg',
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}