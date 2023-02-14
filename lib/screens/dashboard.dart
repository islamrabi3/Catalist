import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/controller/cubit.dart';
import 'package:supervisor/core/globals.dart';
import 'package:supervisor/screens/login.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () => cubit.tokenEmpty().then((value) {
                  navigateTo(context, LoginScreen());
                }),
                child: const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.logout),
                ),
              )
            ],
            centerTitle: true,
            title: Text(cubit.screens[cubit.currentScreenIndex]['title']),
          ),
          body: cubit.screens[cubit.currentScreenIndex]['screen'],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentScreenIndex,
              onTap: (index) => cubit.screenToggle(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'User'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.family_restroom), label: 'Team'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.comment_rounded), label: 'Attendance'),
              ]),
        );
      },
      listener: (context, state) {},
    );
  }
}
