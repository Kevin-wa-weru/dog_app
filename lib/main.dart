import 'package:dog_app/dog_ceo/dog_ceo.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
      providers: Singletons.registerCubits(), child: const DogCeo()));
}
