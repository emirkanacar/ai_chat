import 'package:ai_chat/constant/theme.dart';
import 'package:ai_chat/models/AppSettings.dart';
import 'package:ai_chat/models/Chat/ChatMessageModel.dart';
import 'package:ai_chat/providers/PageProvider.dart';
import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:ai_chat/views/Chat/ChatsScreen.view.dart';
import 'package:ai_chat/views/HomeScreen.view.dart';
import 'package:ai_chat/views/SettingsScreen.view.dart';
import 'package:ai_chat/views/SplashScreen.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/hive/ChatDataModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(ChatDataAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(AppSettingsAdapter());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => PageProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = context.watch<SettingsProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chat',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale("tr"),
        Locale("en")
      ],
      locale: Locale(settingsProvider.appSettings?.language ?? "tr"),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: settingsProvider.appSettings?.theme == "dark" ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/chats': (context) => const ChatsScreen(),
        '/settings': (context) => const SettingsScreen()
      },
    );
  }
}