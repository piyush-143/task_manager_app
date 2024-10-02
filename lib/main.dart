import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/view/home_view.dart';
import 'package:task_manager_app/view_model/priority_provider.dart';
import 'package:task_manager_app/view_model/task_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskListProvider()),
        ChangeNotifierProvider(create: (_) => PriorityProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeView(),
      ),
    );
  }
}
