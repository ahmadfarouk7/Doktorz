import 'package:flutter/material.dart';
import 'package:gradproject/Pages/chatbot.dart';
import 'package:gradproject/Widgets/custom_button.dart';

class ChatbotBording extends StatelessWidget {
  const ChatbotBording({super.key});

  @override
  Widget build(BuildContext context) {
    final Shader linearGardinate = const LinearGradient(
      colors: [
        Color(0xff00E1CB),
        Color(0xff212E42),
      ],
    ).createShader(
      const Rect.fromLTWH(0, 0, 200, 80),
    );
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Hello , I'm TETO",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/bot.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "How can i help you?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                foreground: Paint()..shader = linearGardinate,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatBotPage(),
                  ),
                );
              },
              text: 'I want to know',
              radius: 10,
              color: const Color(0xff25344B),
              textcolor: const Color(0xff00E1CB),
            )
          ],
        ),
      ),
    ));
  }
}
