import 'package:dog_app/features/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class DogCeo extends StatelessWidget {
  const DogCeo({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DogApp',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const DashBoard(),
    );
  }
}
