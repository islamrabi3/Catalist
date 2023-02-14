import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:supervisor/core/globals.dart';
import 'package:supervisor/model/attendance_model.dart';

class AttendanceDetails extends StatelessWidget {
  const AttendanceDetails({super.key, required this.model});

  final AttendanceModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Details'),
      ),
      body: model.message == 'Success'
          ? ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                            baseUrl + model.data!.dataList![index].imgUrl!),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FullName: ${model.data!.dataList![index].fullName!}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('ID : ${model.data!.dataList![index].id!}'),
                              Text(
                                  'Username : ${model.data!.dataList![index].userName!}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.data!.dataList![index].attendance!,
                                    style: GoogleFonts.amiri(color: Colors.red),
                                  ),
                                  Text(
                                    model.data!.dataList![index].checkInDate!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => kSizedBox(),
              itemCount: model.data!.dataList!.length)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
