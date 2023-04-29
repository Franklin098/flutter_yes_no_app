import 'package:flutter/material.dart';
import 'package:flutter_yes_no_app/config/helpers/get_yes_no_answer.dart';

import '../../domain/entities/message.dart';

// a State Manager system help us to get the state of the app without
// going trough the entire widget tree. (component drilling)
class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hello Darling', fromWho: FromWho.me),
    Message(text: 'Are you at home?', fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    // we need to notify that there is a change, and all listener need
    // to re-draw
    notifyListeners();

    moveScrollToBottom();

    if (text.endsWith('?')) {
      mateReply();
    }
  }

  Future<void> mateReply() async {
    final mateMessage = await getYesNoAnswer.getAnswer();
    messageList.add(mateMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
