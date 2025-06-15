import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gradproject/Pages/patient_home.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/models/chat_model.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:gradproject/services/chat_service.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  bool isTyping = false;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<ChatModel> chatList = [];
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isRecording = false;
  String _recognizedText = '';
  final String _displayText = 'Press the button and start speaking...';

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _speechToText.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _recorder.startRecorder(
        toFile: 'audio.aac',
        codec: Codec.aacADTS,
      );

      bool available = await _speechToText.initialize();
      if (available) {
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _recognizedText = result.recognizedWords;
              print(_recognizedText);
              textEditingController.text = _recognizedText;
            });
          },
          cancelOnError: true,
        );
      } else {
        print('Speech recognition not available');
      }

      setState(() {
        _isRecording = true;
      });
    } else {
      print('Microphone permission denied');
    }
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    await _speechToText.stop();
    setState(() {
      _isRecording = false;
    });
    await _sendMessageFromSpeech(_recognizedText);
  }

  Future<void> _sendMessageFromSpeech(String message) async {
    if (message.isNotEmpty) {
      setState(() {
        isTyping = true;
        chatList.add(ChatModel(message: message, chatIndex: 0));
      });
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      final aiResponse = await ChatService().sendMessage(message: message);
      setState(() {
        chatList.add(aiResponse);
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      setState(() {
        isTyping = false;
      });
    }
  }

  Future<void> _sendMessageFromText(String message) async {
    if (message.isNotEmpty) {
      textEditingController.clear();
      setState(() {
        isTyping = true;
        chatList.add(ChatModel(message: message, chatIndex: 0));
      });
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      final aiResponse = await ChatService().sendMessage(message: message);
      setState(() {
        chatList.add(aiResponse);
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      setState(() {
        isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 2,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 20,
                top: 30,
              ),
              decoration: const BoxDecoration(
                color: Color(0xff3E8989),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Image.asset(
                      'assets/images/chatbot.png',
                      width: 32,
                      height: 37,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'TETO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                  left: 8,
                  right: 8,
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    final chat = chatList[index];
                    return chat.chatIndex == 0
                        ? UserChatBubble(msg: chat.message)
                        : AIChatBubble(msg: chat.message);
                  },
                ),
              ),
            ),
            if (isTyping) ...[
              const SpinKitThreeBounce(
                color: Color(0xff3E8989),
                size: 17,
              )
            ],
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      if (_isRecording) {
                        await _stopRecording();
                      } else {
                        await _startRecording();
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      _isRecording ? Icons.mic : Icons.mic_none,
                      color: const Color(0xff3E8989),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: _displayText,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xff9E9E9E)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xff9E9E9E)),
                        ),
                        filled: true,
                        fillColor: const Color(0xffe5e5e5ed),
                      ),
                      onSubmitted: (value) async {
                        await _sendMessageFromText(value.trim());
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _sendMessageFromText(
                          textEditingController.text.trim());
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xff3E8989),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AIChatBubble extends StatelessWidget {
  const AIChatBubble({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Image.asset(
            'assets/images/chatbot.png',
            width: 32,
            height: 37,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 16,
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    msg,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserChatBubble extends StatelessWidget {
  const UserChatBubble({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 16,
                  top: 15,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff3E8989),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  msg,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/onboarding_img2.png'),
        ),
      ],
    );
  }
}
