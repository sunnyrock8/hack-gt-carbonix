import 'dart:convert';
import 'dart:math';

import 'package:carbonix/theme/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat_core;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class AssistantPage extends StatefulWidget {
  AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final _user = const chat_core.User(
      id: '339286c8-2e38-457a-b8d5-b2092e579a7a', name: 'User');
  final _agent = const chat_core.User(
      id: 'b8ecf8ab-2356-4dbf-9ffb-51e9f54b0761', name: 'Assistant');
  final chat_core.InMemoryChatController _chatController =
      chat_core.InMemoryChatController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _chatController.insertMessage(
      chat_core.TextMessage(
        id: randomString(),
        authorId: _user.id,
        createdAt: DateTime.now().toUtc(),
        text: 'Hello',
      ),
    );
  }

  void _sendToChatGPT(chat_core.TextMessage message) async {
    print('Sending to chatgpt');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer OPENAI_API_KEY'
    };
    var data = json.encode({
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              """You are to act as a helpfl digital assistant for a user on our app. Your role is to help users make sustainable decisions about their transport choices. You have been given the following data set to answer user questions:
                Travel distance from Tech Square to Atlanta Airport by car: 10.7 mi.
                Time taken to travel from Tech Square to Atlanta Airpot by car: 16 minutes.
                CO2 emissions for the drive from Tech Square to Atlanta Airport: 4.28 kg.
                Time taken to travel from Tech Square to Atlanta Airpot by MARTA: 2.1 kg.
                CarbonCents credits gained by choosing the MARTA over a private car: \$5 (the value of a sustainably maunfactured pen on the CarbonCents marketplace)

                Travel distance from Tech Square to West Village: 1.4 mi.
                Time taken to travel from Tech Square to West Village by car: 7 minutes.

                The user will tell you where they want to go and you will evaluate the options of car and MARTA for them, focusing on sustainability and explaining to them the advantage of taking the MARTA. If data for the MARTA is not available, suggest that the user use the car. Limit your responses to make them short. Hhighlight the recommended choice clearly at the top and then give a short explanation.
              """
        },
        ..._chatController.messages
            .whereType<chat_core.TextMessage>()
            .map((message) => {
                  "role": message.authorId == _user.id ? "user" : "assistant",
                  "content": message.text,
                })
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://api.openai.com/v1/chat/completions',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      final agentResponse = chat_core.TextMessage(
        id: randomString(),
        authorId: _agent.id,
        createdAt: DateTime.now().toUtc(),
        text: response.data['choices'][0]['message']['content'],
      );
      _chatController.insertMessage(agentResponse);
    } else {
      print(response.statusMessage);
    }
  }

  void _handleMessageSend(String text) {
    final textMessage = chat_core.TextMessage(
      id: randomString(),
      authorId: _user.id,
      createdAt: DateTime.now().toUtc(),
      text: text,
    );
    _chatController.insertMessage(textMessage);
    _sendToChatGPT(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.blue,
      body: Chat(
        chatController: _chatController,
        currentUserId: _user.id,
        onMessageSend: _handleMessageSend,
        resolveUser: (id) async {
          if (id == _user.id) return _user;
          if (id == _agent.id) return _agent;
          return null;
        },
      ),
    );
  }
}
