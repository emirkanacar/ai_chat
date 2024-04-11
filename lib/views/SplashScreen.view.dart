import 'package:ai_chat/MainScreen.dart';
import 'package:ai_chat/models/AppSettings.dart';
import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:ai_chat/providers/UserProvider.dart';
import 'package:ai_chat/views/auth/LoginScreen.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth? auth;
  User? user;
  AppSettings? appSettings;
  bool isAuthenticated = false;
  SettingsProvider? _settingsProvider;
  UserProvider? _userProvider;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    user = auth?.currentUser;
    _settingsProvider = context.read<SettingsProvider>();
    _userProvider = context.read<UserProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _userProvider?.setFirebaseAuth(null);
      }
    });

    _initApp();

    super.initState();
  }

  Future<void> _initApp() async {
    if (user != null) {
      setState(() {
        isAuthenticated = true;
      });
    } else {
      setState(() {
        isAuthenticated = false;
      });
    }

    Box? appBox = await Hive.openBox("app");
    AppSettings? settings = appBox.get("settings");
    AppSettings? defaultSettings = AppSettings(theme: "light", language: "tr", fontSize: 16, notificationSettings: false);

    if (settings == null) {
      await Hive.box("app").put("settings", defaultSettings);

      setState(() {
        appSettings = defaultSettings;
      });

      _settingsProvider?.setAppSettings(defaultSettings);
    } else {
      setState(() {
        appSettings = settings;
      });

      _settingsProvider?.setAppSettings(settings);
    }

    if (isAuthenticated) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ), (route) => route.isFirst);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
              (route) => route.isFirst);
    }

  }


  @override
  Widget build(BuildContext context) {
    _settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("AI Chat", style: GoogleFonts.raleway(fontSize: 32, fontWeight: FontWeight.w700),),
              Text("Yükleniyor...", style: GoogleFonts.raleway(fontSize: 18), textAlign: TextAlign.center,),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
