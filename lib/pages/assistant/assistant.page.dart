import 'dart:convert';
import 'dart:math';

import 'package:carbonix/theme/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

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
  final _user = const types.User(id: '339286c8-2e38-457a-b8d5-b2092e579a7a');
  final _agent = const types.User(id: 'b8ecf8ab-2356-4dbf-9ffb-51e9f54b0761');

  @override
  void initState() {
    super.initState();

    _addMessage(
      types.TextMessage(
        author: _user,
        text: 'Hello',
        id: randomString(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  List<types.TextMessage> _messages = [];

  void _sendToChatGPT(List<types.TextMessage> messages) async {
    print('Sending to chatgpt');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer {{API_KEY}}'
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
        ...messages.map((message) => {
              "role": message.author.id == _user.id ? "user" : "assistant",
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
      final agentResponse = types.TextMessage(
        author: _agent,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: response.data['choices'][0]['message']['content'],
      );
      setState(() {
        _messages.insert(0, agentResponse);
      });
    } else {
      print(response.statusMessage);
    }
  }

  void _addMessage(types.TextMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
    _sendToChatGPT([..._messages, message]);
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.blue,
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
