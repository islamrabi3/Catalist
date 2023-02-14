import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisor/controller/appStates.dart';
import 'package:supervisor/controller/cubit.dart';
import 'package:supervisor/core/components/text_form.dart';
import 'package:supervisor/core/globals.dart';
import 'package:supervisor/screens/dashboard.dart';

// ignore: must_be_immutable
class CheckInScreen extends StatelessWidget {
  CheckInScreen({super.key, required this.file});

  final File file;

  //id controller
  var idController = TextEditingController();
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Check In Screen'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: FileImage(file),
                          radius: 100,
                        ),
                        Positioned(
                          bottom: 5,
                          right: -15,
                          child: IconButton(
                            onPressed: () {
                              cubit.getEmployeeImage(
                                  imageSource: ImageSource.camera);
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                            ),
                            iconSize: 50,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      title: Text('Latitude : ${cubit.latitude ?? ''}'),
                    ),
                    ListTile(
                      title: Text('longitude : ${cubit.longitude ?? ''} '),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        cubit.getCurrentLocation();
                      },
                      child: const Text(
                        'Get Location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormComponent(
                        voidCallback: (value) {
                          if (value!.isEmpty) {
                            return 'Please Fill the Field';
                          }
                        },
                        controller: idController,
                        labelText: 'Enter your id ',
                        keyboardType: TextInputType.text,
                        iconData: Icons.format_italic_rounded,
                        isPassword: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormComponent(
                        voidCallback: (value) {
                          if (value!.isEmpty) {
                            return 'Please Fill the Field';
                          }
                        },
                        controller: commentController,
                        labelText: 'Put your Comment here ',
                        keyboardType: TextInputType.text,
                        iconData: Icons.comment,
                        isPassword: false,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Check in Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            cubit
                                .sendCheckInData(
                                    photoPath: cubit.file!.path,
                                    userId: int.parse(idController.text),
                                    userLatitude: cubit.latitude,
                                    userLongitude: cubit.longitude,
                                    comment: commentController.text)
                                .then((value) {
                              navigateTo(context, const DashBoard());
                            });
                          }
                        },
                        child: const Text(
                          'Check In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
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
