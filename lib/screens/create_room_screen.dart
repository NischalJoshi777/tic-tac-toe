import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/widgets/app_button.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:multiplayertictactoe/widgets/custom_text_filed.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppHeaderText(
              text: "CREATE A ROOM",
              shadow: [
                BoxShadow(
                  color: Colors.orange,
                  blurRadius: 40,
                  spreadRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextEditField(
                hintText: "Enter your game name,",
              ),
            ),
            const SizedBox(height: 20.0),
            AppButton(onPressed: () {}, text: "CREATE"),
          ],
        ),
      ),
    );
  }
}
