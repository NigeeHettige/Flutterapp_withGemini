import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spacepod/bloc/chat_bloc.dart';
import 'package:spacepod/models/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
      bloc: chatBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (ChatSuccessState):
            List<ChatMessageModel> messages =
                (state as ChatSuccessState).messages;
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/space.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 80,
                    // color: Colors.red,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Space Pod",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              fontFamily: 'Centauri'),
                        ),
                        Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 12,left:16,right: 16 ),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color:
                                        const Color.fromARGB(255, 170, 168, 166)
                                            .withOpacity(0.1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      messages[index].role == "user"
                                          ? "user"
                                          : "spacebot",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: messages[index].role == "user"
                                              ? const Color.fromARGB(
                                                  255, 170, 168, 166)
                                              : const Color.fromARGB(
                                                  255, 144, 233, 203)),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      messages[index].parts.first.text,
                                      style: const TextStyle(
                                        fontFamily: 'CENTURION',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ));
                          })),
                  if (chatBloc.generating)
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Lottie.asset("assets/loader.json"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Loading...",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 36),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              fillColor: Colors.white,
                              hintText: "Ask something from spacebot",
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 150, 149, 149),
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                              filled: true,
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'CENTURION',
                                fontWeight: FontWeight.bold),
                            cursorColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            if (textEditingController.text.isNotEmpty) {
                              String text = textEditingController.text;
                              textEditingController.clear();
                              chatBloc.add(ChatGenerateNewTextMessageEvent(
                                  inputMessage: text));
                            }
                          },
                          child: CircleAvatar(
                            radius: 31,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 29,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );

          default:
            return const SizedBox();
        }
      },
    ));
  }
}
