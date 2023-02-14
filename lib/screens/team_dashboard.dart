import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/controller/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../core/globals.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocConsumer<AppCubit, AppStats>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();

        return Scaffold(
          body: Center(
              child: ConditionalBuilder(
            condition: cubit.teamDashboardModel == null,
            builder: (context) {
              cubit.getTeamDashboardData();
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            fallback: (context) {
              return CustomListViewBuilder(baseUrl: baseUrl, cubit: cubit);
            },
          )),
        );
      },
      listener: (context, state) {},
    );
  }
}

class CustomListViewBuilder extends StatelessWidget {
  const CustomListViewBuilder({
    super.key,
    required this.baseUrl,
    required this.cubit,
  });

  final String baseUrl;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.network(baseUrl +
                      cubit.teamDashboardModel!.data!
                          .teamDashboardModules![index].imagePath!),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'ID : ${cubit.teamDashboardModel!.data!.teamDashboardModules![index].id!}'),
                    Text(
                        '${cubit.teamDashboardModel!.data!.teamDashboardModules![index].slaname}'),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount:
            cubit.teamDashboardModel!.data!.teamDashboardModules!.length);
  }
}
