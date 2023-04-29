import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_yes_no_app/domain/entities/message.dart';
import 'package:flutter_yes_no_app/presentation/providers/chat_provider.dart';
import 'package:flutter_yes_no_app/presentation/widgets/chat/mate_message_bubble.dart';
import 'package:flutter_yes_no_app/presentation/widgets/chat/message_bubble.dart';
import 'package:flutter_yes_no_app/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://64.media.tumblr.com/d485473164ae99ecd63358e201ce8412/f3cab93c415a3cea-2f/s128x128u_c1/f8eb9be79ecbc4bffe80a33b1c41f4c9082caae4.jpg')),
          ),
          title: const Text('Darling')),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // we might have multiple context, specify which context you want to use
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                return (message.fromWho == FromWho.mate)
                    ? MateMessageBubble(
                        message: message,
                      )
                    : MessageBubble(
                        message: message,
                      );
              },
            )),
            MessageFieldBox(
              // onValueSubmitted: (value) {
              //   chatProvider.sendMessage(value);
              // },
              // Shorter Version: given that both functions have same parameters
              onValueSubmitted: chatProvider.sendMessage,
            )
          ],
        ),
      ),
    );
  }
}
