import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_app/controller/bloc/employee_bloc.dart';

import 'package:pixel6_app/view/home_screen.dart';
import 'package:pixel6_app/controller/repository/employee_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
        home: BlocProvider(
      create: (context) => EmployeeBloc(EmployeeRepository()),
      child:  HomeScreen(),
    ));
  }
}
