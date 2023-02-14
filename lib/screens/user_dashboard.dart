import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/controller/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocConsumer<AppCubit, AppStats>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        String baseUrl = 'https://csupervisionapi.catalist-me.com/';
        return Scaffold(
          body: Center(
              child: ConditionalBuilder(
            condition: cubit.userDashboardModel == null,
            builder: (context) {
              cubit.getUserDashboardData();
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            fallback: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Image.network(baseUrl +
                                cubit.userDashboardModel!.data!
                                    .mainDashboardModules![index].imagePath!),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'ID : ${cubit.userDashboardModel!.data!.mainDashboardModules![index].id!}'),
                              Text(
                                  '${cubit.userDashboardModel!.data!.mainDashboardModules![index].slaname}'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cubit
                      .userDashboardModel!.data!.mainDashboardModules!.length);
            },
          )),
        );
      },
      listener: (context, state) {},
    );
  }
}
