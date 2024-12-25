import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
import 'package:multiplayertictactoe/widgets/app_button.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:multiplayertictactoe/widgets/custom_text_filed.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final SocketMethods _methods = SocketMethods();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _methods.createRoomSuccessListener(context);
  }

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextEditField(
                controller: _nameController,
                hintText: "Enter your game name,",
              ),
            ),
            const SizedBox(height: 20.0),
            AppButton(
                onPressed: () {
                  _methods.createRoom(nickname: _nameController.text);
                },
                text: "CREATE"),
          ],
        ),
      ),
    );
  }
}
