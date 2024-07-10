import 'package:flutter/material.dart';
import 'package:type_racer/screens/createScreen.dart';
import 'package:type_racer/screens/home_screen.dart';
import 'package:type_racer/screens/joinScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TypeRacer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes : {
        '/' :(context) => const HomeScreen(),
        '/create-room' :(context) => const CreateRoomScreen(),
        '/join-room' :(context) => const JoinRoomScreen(),
      }
    );
  }
}

