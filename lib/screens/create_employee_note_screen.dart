import 'package:flutter/material.dart';

class CreateEmployeeNoteScreen extends StatelessWidget {
  const CreateEmployeeNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
            const Text("hi create note screen"),
          ],
        ),
      ),
    );
  }
}
