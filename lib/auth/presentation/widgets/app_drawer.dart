import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/auth/cubit/auth_cubit.dart';
import 'package:test_app/auth/presentation/screens/login_screen.dart';
import 'package:test_app/const/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [

          UserAccountsDrawerHeader(
            decoration:  BoxDecoration(
              color: AppColors.primary,
            ),
            accountName: const Text("User name"),
            accountEmail: const Text("User email.."),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text("My QR Code"),
            onTap: () {
              Navigator.pop(context);
              // go to QR screen
            },
          ),

          ListTile(
            leading: const Icon(Icons.fastfood),
            title: const Text("My Meals"),
            onTap: () {},
          ),

          ///  Scan (Admin)
          ListTile(
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text("Scan QR"),
            onTap: () {},
          ),

          const Spacer(),

          ///  Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
               context.read<AuthCubit>().logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
              );

            },
          ),
        ],
      ),
    );
  }
}