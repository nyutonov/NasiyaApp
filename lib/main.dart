import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasiya_app/presentation/pages/add_client/add_client_bloc.dart';
import 'package:nasiya_app/presentation/pages/add_client/add_client_page.dart';
import 'package:nasiya_app/presentation/pages/add_employee/add_employee_bloc.dart';
import 'package:nasiya_app/presentation/pages/add_employee/add_employee_page.dart';
import 'package:nasiya_app/presentation/pages/add_payment/add_payment_bloc.dart';
import 'package:nasiya_app/presentation/pages/add_payment/add_payment_page.dart';
import 'package:nasiya_app/presentation/pages/add_sale/add_sale_bloc.dart';
import 'package:nasiya_app/presentation/pages/add_sale/add_sale_page.dart';
import 'package:nasiya_app/presentation/pages/bottom_navigation/bottom_navigation_page.dart';
import 'package:nasiya_app/utils/work_manager.dart';
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/bottom_navigation',
      routes: {
        '/bottom_navigation': (context) =>
            const BottomNavigationPage(),
        '/add_sale': (context) =>
            BlocProvider(
              create: (context) => AddSaleBloc(),
              child: AddSalePage(),
            ),
        '/add_client': (context) =>
            BlocProvider(
              create: (context) => AddClientBloc(),
              child: const AddClientPage(),
            ),
        '/add_employee': (context) =>
            BlocProvider(
              create: (context) => AddEmployeeBloc(),
              child: const AddEmployeePage(),
            ),
        '/add_payment': (context) =>
            BlocProvider(
              create: (context) => AddPaymentBloc(),
              child: const AddPaymentPage(),
            )
      },
    );
  }
}