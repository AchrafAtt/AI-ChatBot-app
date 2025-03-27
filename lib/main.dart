import 'package:chat_bot/chat/presentation/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat/presentation/chat_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ChatProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: ChatPage(),
    );
  }
}
