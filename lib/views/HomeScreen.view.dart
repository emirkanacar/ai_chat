import 'dart:convert';

import 'package:ai_chat/components/AppWrapper.dart';
import 'package:ai_chat/components/ButtonWithIcon.dart';
import 'package:ai_chat/components/CategoryButton.dart';
import 'package:ai_chat/components/PromptBox.dart';
import 'package:ai_chat/models/suggestion.dart';
import 'package:ai_chat/views/Chat/ChatScreen.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Suggestion? suggestions;
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    fetchSuggestions();
  }

  Future<void> fetchSuggestions() async {
    final String response = await rootBundle.loadString('assets/data/suggestions.json');
    final data = await json.decode(response);


    setState(() {
      suggestions = Suggestion.fromJson(data);
    });
  }

  void _showChatModal(String? prompt) {
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
              child: ChatScreen(promptText: prompt, isNewChat: true,),
            );
          },
        );
      },
    );
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: Text(AppLocalizations.of(context)!.homepageTitle, style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w900,
                            fontSize: 36
                        ),)
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(AppLocalizations.of(context)!.homepageDescription, style: GoogleFonts.raleway(
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        ),)
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ButtonWithIcon(
                  icon: HeroIcons.plus,
                  onPressed: () {
                    _showChatModal(null);
                  },
                )
              )
            ],
          ),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
           child: SizedBox(
             height: 40,
             child: ListView.builder(
                 itemCount: suggestions?.data.length,
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (BuildContext context, int index) {
                   return CategoryButton(
                     buttonText: suggestions?.data[index].categoryName ?? "",
                     isSelected: selectedCategoryIndex == index,
                     onTap: () {
                       setState(() {
                         selectedCategoryIndex = index;
                       });
                     },
                   );
                 }
             ),
           ),
         ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: ListView.builder(
                itemCount: suggestions?.data[selectedCategoryIndex].prompts.length,
                itemBuilder: (BuildContext context, int index) {
                  return PromptBox(
                      promptText: suggestions?.data[selectedCategoryIndex].prompts[index].prompt ?? "",
                      onTap: () {
                        _showChatModal(suggestions?.data[selectedCategoryIndex].prompts[index].promptCode);
                      }
                  );
                },
              )
            )
          )
        ],
      ),
    );
  }
}
