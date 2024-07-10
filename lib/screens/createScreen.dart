import 'package:flutter/material.dart';
import 'package:type_racer/widgets/customTextField.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Create Room" , style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: size.height * 0.08,),
            CustomTextField(controller: _nameController, hintText: "Enter Your Nickname",)
          ],
        ),
      ),
      ),
    )
    );
  }
}