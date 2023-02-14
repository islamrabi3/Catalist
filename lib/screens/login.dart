import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/controller/cubit.dart';

import 'package:supervisor/core/components/text_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supervisor/core/globals.dart';
import 'package:supervisor/screens/check_in%20_screen.dart';
import 'package:supervisor/screens/dashboard.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.grey,
                    Colors.blueGrey,
                  ]),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Employee Attendance',
                                textStyle: GoogleFonts.lato(
                                        fontStyle: FontStyle.italic)
                                    .copyWith(
                                        fontSize: 30.0, color: Colors.black54)),
                          ],
                          repeatForever: true,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormComponent(
                          isPassword: false,
                          controller: username,
                          iconData: Icons.person,
                          keyboardType: TextInputType.text,
                          labelText: 'Username',
                          voidCallback: (value) {
                            if (value!.isEmpty) {
                              return 'Username must not be Empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormComponent(
                          isPassword: true,
                          controller: password,
                          iconData: Icons.password,
                          keyboardType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          voidCallback: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be Empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormComponent(
                          isPassword: false,
                          controller: id,
                          iconData: Icons.numbers,
                          keyboardType: TextInputType.number,
                          labelText: 'LangID',
                          voidCallback: (value) {
                            if (value!.isEmpty) {
                              return 'LangID must not be Empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  cubit
                                      .loginMethod(
                                          name: username.text,
                                          password: password.text,
                                          langID: int.parse(id.text))
                                      .then((value) async {
                                    if (cubit.userModel!.data!.userData!
                                        .userinfo!.checkedIn!) {
                                      navigateTo(context, const DashBoard());
                                    } else {
                                      cubit
                                          .getEmployeeImage(
                                              imageSource: ImageSource.camera)
                                          .then((value) {
                                        if (cubit.file != null) {
                                          navigateTo(context,
                                              CheckInScreen(file: cubit.file!));
                                        } else {
                                          navigateTo(context, LoginScreen());
                                        }
                                      });
                                    }
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  textStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold)
                                      .copyWith(fontSize: 25.0)),
                              child: const Text('LOGIN')),
                        ),
                        if (state is AppPostMethodLoadingState)
                          const LinearProgressIndicator()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
