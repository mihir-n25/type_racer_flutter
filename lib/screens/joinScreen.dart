import 'package:flutter/material.dart';
import 'package:type_racer/widgets/customButton.dart';
import 'package:type_racer/widgets/customTextField.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Create Room" , style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: size.height * 0.08,),
           CustomTextField(controller: _nameController, hintText: "Enter Your Nickname"
            ),
             const SizedBox(
              height: 20,
            ),
           CustomTextField(controller: _gameIdController, hintText: "Enter Your GameId"
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(text: "Join", onTap: () {})
          ],
        ),
      ),
      ),
    )
    );
  }
}