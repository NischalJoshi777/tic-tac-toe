import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/providers/room_details_provider.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:multiplayertictactoe/widgets/custom_text_filed.dart';
import 'package:provider/provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController _roomIdController;

  @override
  void initState() {
    _roomIdController = TextEditingController();
    _roomIdController.text =
        Provider.of<RoomDetailsProvider>(context, listen: false)
            .roomData['_id'];
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppHeaderText(text: 'Waiting for a player to join'),
          const SizedBox(height: 20.0),
          CustomTextEditField(
            readOnly: true,
            hintText: "",
            controller: _roomIdController,
          ),
        ],
      ),
    );
  }
}
