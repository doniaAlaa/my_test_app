import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/auth/cubit/auth_cubit.dart';
import 'package:test_app/auth/cubit/auth_state.dart';
import 'package:test_app/auth/data/data_source/auth_local_db.dart';
import 'package:test_app/auth/presentation/widgets/app_drawer.dart';
import 'package:test_app/const/App_images.dart';
import 'package:test_app/const/primary_app_btn.dart';
import 'package:test_app/home/cubit/meals_cubit.dart';
import 'package:test_app/home/cubit/meals_state.dart';
import 'package:test_app/home/data/data_source/meals_data_source.dart';

import '../../auth/data/repo/auth_repo.dart';
import '../data/repo/meals_repo.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(
            AuthRepo(AuthLocalData()),
          )..loadUser(),
        ),
        BlocProvider(
          create: (_) => MealsCubit(
            MealsRepo(MealsLocalDataSource()),
          )..loadMeals(),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool isAdmin = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: 20),

              /// 👤 User Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is UserLoaded) {
                        return Text(
                          "Hello ${state.user.name} 👋",
                          style: const TextStyle(fontSize: 22),
                        );
                      }

                      if (state is LoginError) {
                        return Text(state.message);
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: const Icon(Icons.menu, size: 28),
                  )
                ],
              ),

              const SizedBox(height: 4),

              Text(
                isAdmin ? "Admin Panel" : "Your Subscription Overview",
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              /// Plan Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Active Plan",
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 6),
                    Text(
                      "Diet Plan - 3 Meals / Day",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Remaining Meals: 12",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// QR
              if (!isAdmin)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        AppImages.qr,
                        width: 140,
                        height: 140,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text("Scan this code to manage meals"),
                  ],
                ),

              const SizedBox(height: 20),

              ///  Title
              const Text(
                "Today's Meals",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// 🍽️ Meals from Cubit
              BlocBuilder<MealsCubit, MealsState>(
                builder: (context, state) {
                  if (state is MealsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MealsLoaded) {
                    return Column(
                      children: state.meals.map((meal) {
                        return MealCard(
                          title: meal.title,
                          desc: meal.desc,
                        );
                      }).toList(),
                    );
                  }

                  if (state is MealsError) {
                    return Text(state.message);
                  }

                  return const SizedBox();
                },
              ),

              const SizedBox(height: 20),

              /// Buttons
              Row(
                children: [
                  if (isAdmin)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Scan QR"),
                      ),
                    ),

                  if (isAdmin) const SizedBox(width: 10),

                  Expanded(
                    child: MainButton(
                      text: isAdmin ? "Manage Users" : "My Plan",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String title;
  final String desc;

  const MealCard({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.fastfood),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(desc),
            ],
          ),
        ],
      ),
    );
  }
}