import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
import 'package:multiplayertictactoe/widgets/app_button.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:multiplayertictactoe/widgets/custom_text_filed.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController();
  final SocketMethods _socket = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socket.joinRoomSuccessListener(context);
    _socket.errorOccuredListener(context);
    _socket.updatePlayersStateListener(context);
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextEditField(
                controller: _roomIdController,
                hintText: "Enter your room ID,",
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextEditField(
                hintText: "Enter your game name,",
                controller: _nameController,
              ),
            ),
            const SizedBox(height: 20.0),
            AppButton(
              onPressed: () {
                _socket.joinRoom(
                  _nameController.text.trim(),
                  _roomIdController.text.trim(),
                );
              },
              text: "Join",
            ),
          ],
        ),
      ),
    );
  }
}
