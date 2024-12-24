import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/widgets/app_button.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:multiplayertictactoe/widgets/custom_text_filed.dart';

class JoinRoomScreen extends StatelessWidget {
  const JoinRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppHeaderText(
              text: "JOIN A ROOM",
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
                hintText: "Enter your room ID,",
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextEditField(
                hintText: "Enter your game name,",
              ),
            ),
            const SizedBox(height: 20.0),
            AppButton(onPressed: () {}, text: "Join"),
          ],
        ),
      ),
    );
  }
}
