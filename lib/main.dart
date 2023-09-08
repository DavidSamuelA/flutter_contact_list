import 'package:flutter/material.dart';
import 'package:flutter_contact_list/contact_list_screen.dart';
import 'package:flutter_contact_list/database_helper.dart';

final dbHelper = DatabaseHelper();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
    );
  }
}
