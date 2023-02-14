import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

navigatePushTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

int? globalUserId;
int? globalLangId = 1;

String token = '';

const String baseUrl = 'https://csupervisionapi.catalist-me.com/';

SizedBox kSizedBox() {
  return const SizedBox(
    height: 20,
  );
}
//  var cubit = context.read<AppCubit>();