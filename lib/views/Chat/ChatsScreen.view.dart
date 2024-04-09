import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

import '../../components/AppWrapper.dart';
import '../../components/ButtonWithIcon.dart';
import '../../components/Chat/ChatListItem.dart';
import '../../models/Chat/ChatMessageModel.dart';
import '../../models/hive/ChatDataModel.dart';
import 'ChatScreen.view.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  Box<ChatData>? chatDataBox;
  bool chatsLoading = true;
  List<ChatData>? chats;

  @override
  void initState() {
    _initHive();

    super.initState();
  }

  _initHive() async {
    chatDataBox = await Hive.openBox<ChatData>("chatMessages");

    setState(() {
      chats = List.from(chatDataBox!.values.toList());

      chats?.sort((a, b){
        return DateTime.parse(b.lastModifiedDate).compareTo(DateTime.parse(a.lastModifiedDate));
      });

      chatsLoading = false;
    });
  }

  _updateData() async {
    setState(() {
      chatsLoading = true;
    });

    chatDataBox = await Hive.openBox<ChatData>("chatMessages");

    setState(() {
      chats = List.from(chatDataBox!.values.toList());

      chats?.sort((a, b){
        return DateTime.parse(b.lastModifiedDate).compareTo(DateTime.parse(a.lastModifiedDate));
      });

      chatsLoading = false;
    });
  }

  void _showChatModal(List<ChatMessage>? chatMessages, int? selectedModel) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext modalContext) {
        return LayoutBuilder(
          builder: (modalContext, _) {
            return AnimatedPadding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              child: ChatScreen(isNewChat: false, messages: chatMessages, model: selectedModel,),
            );
          },
        );
      },
    );
  }

  Future<void> _deleteChat(ChatData? chatData) async {
    for (var message in chatData!.messages) {
      for (var image in message.images) {
        await File(image).delete();
      }
    }

    chatDataBox?.delete(chatData.chatID).then((value) async {
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text("Başarılı", style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
        description: Text("Sohbet kaydı başarıyla silindi!", style: GoogleFonts.raleway()),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
      );

      await _updateData();
    }).catchError((error) async {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: Text("Hata", style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
        description: Text("Sohbet kaydı silinirken hata oluştu!", style: GoogleFonts.raleway()),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
      );

      await _updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 0, right: 20, left: 20),
                      child: Text(AppLocalizations.of(context)!.chatsTitle, style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w900,
                          fontSize: 36
                      ),)
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Text(AppLocalizations.of(context)!.chatsDescription, style: GoogleFonts.raleway(
                          textStyle: Theme.of(context).textTheme.labelSmall,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                      ),)
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: ButtonWithIcon(
                  icon: HeroIcons.plus,
                  onPressed: () {
                    _showChatModal(null, 1);
                  },
                )
              )
            ],
          ),
          chatsLoading ? Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: SizedBox(
                height: 64,
                width: 64,
                child: CircularProgressIndicator(
                  color: Color(0xFF282828),
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ) :
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _updateData();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: ListView.builder(
                  itemCount: chats?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatListItem(
                      onTap: () {
                        _showChatModal(chats?[index].messages, chats?[index].AIType);
                      },
                      onDeleteButtonTap: () {
                        _deleteChat(chats?[index]);
                      },
                      title: "Sohbetim ${index + 1}",
                      description: chats?[index].messages.first.message.toString() ?? "",
                      date: chats?[index].lastModifiedDate ?? "",
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
