import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spacepod/models/chat_message_model.dart';
import 'package:spacepod/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages:[])) {
   on< ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);

   
  }
 List<ChatMessageModel> message = [];
 bool generating = false;

  FutureOr<void> chatGenerateNewTextMessageEvent(ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async{
    message.add(ChatMessageModel(role:"user",parts:[ChatPartModel(text:event.inputMessage)] ));
    emit((ChatSuccessState(messages: message)));
    generating = true;
    String generatedText = await ChatRepo.chatTextGenerationRepo(message);
    if(generatedText.isNotEmpty){
      message.add(ChatMessageModel(role: 'model', parts: [ChatPartModel(text: generatedText)]));
       emit((ChatSuccessState(messages: message)));
    }
    generating = false;
  }
}
