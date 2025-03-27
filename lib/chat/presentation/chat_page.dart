import 'package:chat_bot/chat/presentation/chat_bubble.dart';
import 'package:chat_bot/chat/presentation/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //controller for the text field
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //top section : chat messages
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  //empty chat
                  if (chatProvider.messages.isEmpty) {
                    return Center(child: Text("Start a conversation"));
                  }

                  //chat messages
                  return ListView.builder(
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messages[index];
                      return ChatBubble(message: message);
                    },
                  );
                },
              ),
            ),
            //loading indicator
            Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.isLoading) {
                  return const CircularProgressIndicator();
                }
                return const SizedBox.shrink();
              },
            ),

            Row(
              children: [
                //left text field
                Expanded(child: TextField(controller: _textController)),

                //right send button
                IconButton(
                  onPressed: () {
                    if (_textController.text.trim().isNotEmpty) {
                      final chatProvider = context.read<ChatProvider>();
                      chatProvider.sendMessage(_textController.text);
                      _textController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
