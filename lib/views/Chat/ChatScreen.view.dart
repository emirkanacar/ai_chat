import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:ai_chat/components/AppInput.dart';
import 'package:ai_chat/components/ButtonWithIcon.dart';
import 'package:ai_chat/components/Chat/MessageBubble.dart';
import 'package:ai_chat/helpers/functions.dart';
import 'package:ai_chat/models/Chat/ChatMessageModel.dart';
import 'package:ai_chat/models/hive/ChatDataModel.dart';
import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:ai_chat/services/GeminiService.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    this.promptText,
    required this.isNewChat,
    this.chatId,
    this.messages,
    this.model
  }): super(key: key);

  final String? promptText;
  final bool isNewChat;
  final String? chatId;
  final List<ChatMessage>? messages;
  final int? model;

  @override
  State<ChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SettingsProvider? _settingsProvider;

  List<String> selectedImages = [];
  List<ChatMessage> chatMessages = [];
  bool waitingResponse = false;

  GeminiService? geminiService;
  int selectedModel = 0;

  late Box<ChatData> chatDataBox;
  String chatId = "";
  bool isCurrentNew = false;

  @override
  void initState() {
    geminiService = GeminiService();
    geminiService?.init();
    messageController.text = widget.promptText ?? "";

    _settingsProvider = context.read<SettingsProvider>();

    if (widget.isNewChat) {
      chatId = const Uuid().v4();
      isCurrentNew = true;
    } else {
      chatId = widget.chatId ?? "";
      isCurrentNew = false;
    }

    if (widget.messages != null) {
      chatMessages = widget.messages!;
    }

    if (widget.model != null) {
      selectedModel = widget.model ?? 0;
    }

    if (widget.isNewChat == false) {
      if (mounted) {
        scrollBottom();
      }
    }

    _initHive();
    super.initState();
  }

  _initHive() async {
    chatDataBox = await Hive.openBox<ChatData>("chatMessages");
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _generateGeminiContent(String promptText) async {
    List<String> imagesList = List.from(selectedImages);

    setState(() {
      messageController.text = "";
      chatMessages.add(ChatMessage(id: Uuid().toString(), message: promptText, isUserMessage: true, date: DateTime.now().toIso8601String(), images: imagesList));
      waitingResponse = true;
    });

    if (isCurrentNew) {
      chatDataBox.put(chatId, ChatData(chatID: chatId, username: _auth.currentUser?.email ?? "null", AIType: selectedModel, messages: chatMessages, lastModifiedDate: DateTime.now().toIso8601String()));

      setState(() {
        isCurrentNew = false;
      });
    }

    scrollBottom();

    if (selectedImages.isEmpty) {
      geminiService?.textPrompt(promptText).then((value) {
        setState(() {
          chatMessages.add(ChatMessage(id: Uuid().toString(), message: value?.text.toString(), isUserMessage: false, date: DateTime.now().toIso8601String(), images: []));
          waitingResponse = false;
          chatDataBox.put(chatId, ChatData(chatID: chatId, username: _auth.currentUser?.email ?? "null", AIType: selectedModel, messages: chatMessages, lastModifiedDate: DateTime.now().toIso8601String()));
        });

        scrollBottom();
      }).catchError((onError) {
        setState(() {
          chatMessages.add(ChatMessage(id: Uuid().toString(), message: "Merhaba, cevap oluştulurken hata oluştu! Hata: ${onError.toString()}", isUserMessage: false, date: DateTime.now().toIso8601String(), images: []));
          waitingResponse = false;
          chatDataBox.put(chatId, ChatData(chatID: chatId, username: _auth.currentUser?.email ?? "null", AIType: selectedModel, messages: chatMessages, lastModifiedDate: DateTime.now().toIso8601String()));
        });

        scrollBottom();
      });
    } else {
      List<ByteData> images = [];

      for (var image in selectedImages) {
        File imageFile = File(image);
        var readAsByte = await imageFile.readAsBytes();
        images.add(readAsByte.buffer.asByteData());
      }

      geminiService?.imagePrompt(promptText, images).then((value) {
        setState(() {
          chatMessages.add(ChatMessage(id: Uuid().toString(), message: value?.text.toString(), isUserMessage: false, date: DateTime.now().toIso8601String(), images: []));
          waitingResponse = false;
          chatDataBox.put(chatId, ChatData(chatID: chatId, username: _auth.currentUser?.email ?? "null", AIType: selectedModel, messages: chatMessages, lastModifiedDate: DateTime.now().toIso8601String()));
          selectedImages.clear();
        });

        scrollBottom();
      }).catchError((onError) {
        setState(() {
          chatMessages.add(ChatMessage(id: Uuid().toString(), message: "Merhaba, cevap oluştulurken hata oluştu! Hata: ${onError.toString()}", isUserMessage: false, date: DateTime.now().toIso8601String(), images: []));
          waitingResponse = false;
          chatDataBox.put(chatId, ChatData(chatID: chatId, username: _auth.currentUser?.email ?? "null", AIType: selectedModel, messages: chatMessages, lastModifiedDate: DateTime.now().toIso8601String()));
          selectedImages.clear();
        });

        scrollBottom();
      });
    }
  }

  void scrollBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  void _showImageOptionsModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext modalContext) {
        return LayoutBuilder(
          builder: (modalContext, _) {
            return AnimatedPadding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.3,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF282828),
                          child: Icon(AntDesign.camera_outline, size: 22, color: Colors.white,),
                        ),
                        title: Text(
                          "Kamera ile görüntü ekle!",
                          style: GoogleFonts.raleway(
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                        onTap: () async {
                          await picker.pickImage(source: ImageSource.camera);
                        },
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF282828),
                          child: Icon(HeroIcons.photo, size: 22, color: Colors.white,),
                        ),
                        title: Text(
                          "Galeriden görüntü ekle!",
                          style: GoogleFonts.raleway(
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                        onTap: () async {
                          picker.pickImage(source: ImageSource.gallery).then((selectedImage) async {
                            if (selectedImage != null) {

                              String saveImageToLocalPath = await saveFile(File(selectedImage.path), "${chatId}_${DateTime.now().millisecondsSinceEpoch}");

                              setState(() {
                                selectedImages.add(saveImageToLocalPath);
                              });

                              Navigator.pop(context);
                            }
                          });
                        },
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF282828),
                          child: Icon(AntDesign.file_outline, size: 22, color: Colors.white,),
                        ),
                        title: Text(
                          "Dosyalardan görüntü ekle!",
                          style: GoogleFonts.raleway(
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _settingsProvider = context.watch<SettingsProvider>();

    return FractionallySizedBox(
      heightFactor: 0.9,
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Flexible(
              flex: MediaQuery.of(context).viewInsets.bottom != 0 ? 45 : 20,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Icon(
                              HeroIcons.ellipsis_vertical,
                              size: 32,
                              color: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: "delete",
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(HeroIcons.trash, size: 18, color: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black),
                                    ),
                                    Text("Sohbeti Sil", style: GoogleFonts.raleway(
                                      color: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black
                                    ),)
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) {

                            },
                            dropdownStyleData: DropdownStyleData(
                              width: 160,
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme.of(context).dialogBackgroundColor,
                                  border: Border.fromBorderSide(BorderSide(color: Theme.of(context).dividerColor))
                              ),
                              offset: const Offset(0, 0),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              customHeights: [
                                48,
                              ],
                              padding: const EdgeInsets.only(left: 16, right: 0),
                            ),
                            buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    border: Border.fromBorderSide(BorderSide(color: Colors.transparent)),
                                    borderRadius: BorderRadius.circular(16)
                                )
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                                child: Text("AI Chat", style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    textStyle: Theme.of(context).textTheme.bodyLarge
                                ),)
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                                child: Text(isCurrentNew ? "New Chat" : "Messages", style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  textStyle: Theme.of(context).textTheme.labelSmall
                                ),)
                            ),
                          ],
                        ),
                        ButtonWithIcon(
                          icon: HeroIcons.x_mark,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AnimatedToggleSwitch<int>.size(
                    current: min(selectedModel, 1),
                    style: ToggleStyle(
                      backgroundColor: _settingsProvider?.appSettings?.theme == "dark" ? Color(0xFF1E1D1D) : Color(0xFFFDFDFD),
                      indicatorColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.black.withOpacity(0.6) : Colors.black,
                      borderColor: Color(0xFF313131),
                      borderRadius: BorderRadius.circular(8.0),
                      indicatorBorderRadius: BorderRadius.zero,
                    ),
                    values: const [0, 1],
                    height: 40,
                    iconOpacity: 1.0,
                    selectedIconScale: 1.0,
                    indicatorSize: Size.fromWidth(100),
                    iconAnimationType: AnimationType.onHover,
                    styleAnimationType: AnimationType.onHover,
                    spacing: 1.0,
                    customSeparatorBuilder: (context, local, global) {
                      final opacity =
                      ((global.position - local.position).abs() - 0.5)
                          .clamp(0.0, 1.0);
                      return VerticalDivider(
                          indent: 10.0,
                          endIndent: 10.0,
                          color: Colors.red.withOpacity(opacity));
                    },
                    customIconBuilder: (context, local, global) {
                      final text = const ['ChatGPT', 'Gemini'][local.index];
                      return Center(
                          child: Text(text,
                              style: GoogleFonts.raleway(
                                  color: Color.lerp(_settingsProvider?.appSettings?.theme == "dark" ? Colors.white60 : Color(0xff1f1f1f), Colors.white, local.animationValue)
                              )
                          )
                      );
                    },
                    borderWidth: 1.5,
                    onChanged: (i) => setState(() => selectedModel = i),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(color: Theme.of(context).dividerColor),
                ],
              ),
            ),
            Flexible(
              flex: 70,
              fit: FlexFit.tight,
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  itemCount: chatMessages.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext listViewContext, int index) {
                    return MessageBubble(messageText: chatMessages[index].message.toString(), direction: chatMessages[index].isUserMessage ?? true, messageDate: chatMessages[index].date.toString(), isLoading: chatMessages.length - 1 == index ? waitingResponse : false, images: chatMessages[index].images,);
                  },
                )
              ),
            ),
            Flexible(
              flex: MediaQuery.of(context).viewInsets.bottom != 0 ? selectedImages.isNotEmpty ? 26 : 18 : selectedImages.isNotEmpty ? 12 : 9,
              fit: FlexFit.tight,
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 0, right: 20, left: 20, top: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      selectedImages.isNotEmpty ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedImages.clear();
                              });

                              toastification.show(
                                context: context,
                                type: ToastificationType.info,
                                style: ToastificationStyle.flatColored,
                                title: Text("Bilgilendirme", style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                description: Text("Görüntüler başarıyla kaldırıldı!", style: GoogleFonts.raleway()),
                                alignment: Alignment.topCenter,
                                autoCloseDuration: const Duration(seconds: 3),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF282828),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                              child: Icon(HeroIcons.x_mark, color: Colors.white, size: 18,),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "${selectedImages.length} görüntü seçildi!",
                              style: GoogleFonts.raleway(
                                textStyle: Theme.of(context).textTheme.labelSmall
                              ),
                            ),
                          )
                        ],
                      ) : Container(),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: ButtonWithIcon(
                              icon: HeroIcons.document,
                              onPressed: _showImageOptionsModal,
                              iconSize: 20,
                            )
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 12,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: AppInput(
                                controller: messageController,
                                maxLines: 1,
                                isDense: true,
                                contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                                hintText: "Message...",
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: ButtonWithIcon(
                              icon: HeroIcons.paper_airplane,
                              isLoading: waitingResponse,
                              iconSize: 20,
                              onPressed: () {
                                if (selectedModel == 0) {

                                } else if (selectedModel == 1) {
                                  _generateGeminiContent(messageController.text);
                                }
                              },
                            )
                          ),
                        ],
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      )
    );
  }
}
