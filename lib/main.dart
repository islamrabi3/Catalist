import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supervisor/controller/cubit.dart';
import 'package:supervisor/core/globals.dart';
import 'package:supervisor/core/service/cache_helper.dart';
import 'package:supervisor/core/service/dio_helper.dart';
import 'package:supervisor/screens/dashboard.dart';
import 'package:supervisor/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.dioInit();
  await CacheHelper.init();
  token = CacheHelper.prefs?.getString('token') ?? '';
  globalLangId = CacheHelper.prefs?.getInt('langID') ?? 1;
  globalLangId = CacheHelper.prefs?.getInt('userID') ?? 7;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SuperVisor',
        theme: ThemeData(
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.amiri(
            fontSize: 15.0,
          )),
          brightness: Brightness.dark,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: token.isEmpty ? LoginScreen() : const DashBoard(),
      ),
    );
  }
}
