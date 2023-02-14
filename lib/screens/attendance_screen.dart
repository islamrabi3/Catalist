import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/controller/cubit.dart';
import 'package:supervisor/core/globals.dart';
import 'package:supervisor/screens/attendance_details.dart';

import '../core/components/text_form.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// ignore: must_be_immutable
class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var pageNumber = TextEditingController();
  var pageSize = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  var userId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocConsumer<AppCubit, AppStats>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(children: [
                  TextFormComponent(
                    isPassword: false,
                    controller: pageNumber,
                    iconData: Icons.pages,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Page Number',
                    voidCallback: (value) {
                      if (value!.isEmpty) {
                        return 'PageNumber must not be Empty';
                      }
                      return null;
                    },
                  ),
                  kSizedBox(),
                  TextFormComponent(
                    isPassword: false,
                    controller: pageSize,
                    iconData: Icons.add_link,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Page Size',
                    voidCallback: (value) {
                      if (value!.isEmpty) {
                        return 'PageSize must not be Empty';
                      }
                      return null;
                    },
                  ),
                  kSizedBox(),
                  TextFormComponent(
                    onTap: () async {
                      await DatePicker.showDatePicker(
                        context,
                      ).then((value) {
                        startDate.text = value!.toIso8601String();
                      });
                    },
                    isPassword: false,
                    controller: startDate,
                    iconData: Icons.date_range,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Start Date',
                    voidCallback: (value) {
                      if (value!.isEmpty) {
                        return 'Start Date must not be Empty';
                      }
                      return null;
                    },
                  ),
                  kSizedBox(),
                  TextFormComponent(
                    onTap: () async {
                      await DatePicker.showDatePicker(
                        context,
                      ).then((value) {
                        endDate.text = value!.toIso8601String();
                      });
                    },
                    isPassword: false,
                    controller: endDate,
                    iconData: Icons.date_range,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'End Date',
                    voidCallback: (value) {
                      if (value!.isEmpty) {
                        return 'End Date must not be Empty';
                      }
                      return null;
                    },
                  ),
                  kSizedBox(),
                  TextFormComponent(
                    isPassword: false,
                    controller: userId,
                    iconData: Icons.numbers,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'User ID ..',
                    voidCallback: (value) {
                      if (value!.isEmpty) {
                        return 'User ID  must not be Empty';
                      }
                      return null;
                    },
                  ),
                  kSizedBox(),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await cubit
                              .getAttendanceMethod(
                                  pageNumber: int.parse(pageNumber.text),
                                  pageSize: int.parse(pageSize.text),
                                  endDate: endDate.text,
                                  startDate: startDate.text,
                                  userId: int.parse(userId.text))
                              .then((value) {
                            navigatePushTo(
                                context, AttendanceDetails(model: value));
                          });
                        }
                      },
                      child: const Text('Get Attendance Data')),
                  if (state is AttendanceMethodLoadingState)
                    const LinearProgressIndicator()
                ]),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
