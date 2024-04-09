import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/AppInput.dart';
import '../components/AppWrapper.dart';
import '../components/SettingsBox.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _newPasswordAgain = TextEditingController();

  SettingsProvider? _settingsProvider;
  double slidingValue = 16;

  @override
  void initState() {
    _settingsProvider = context.read<SettingsProvider>();
    slidingValue = _settingsProvider?.appSettings?.fontSize.toDouble() ?? 16;

    super.initState();
  }

  void _showProfileModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          widthFactor: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 40),
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 43,
                    backgroundColor: Theme.of(context).dialogBackgroundColor.withOpacity(0.5),
                    child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/default_profile_image.jpg")
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                          child: Text("Emirkan Acar", style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                              fontSize: 20
                          ),)
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                          child: Text("emirkanacar@outlook.com.tr", style: GoogleFonts.raleway(
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),)
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 30),
                          child: Text("Kişisel Bilgilerin", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Text("İsim Soyisim", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontSize: 15,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: AppInput(
                          controller: _firstNameController,
                          filled: true,
                          hintText: "İsim Soyisim",
                          prefixIcon: HeroIcons.user,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Text("Email Adresin", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontSize: 15,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: AppInput(
                          controller: _emailController,
                          filled: true,
                          hintText: "Email",
                          prefixIcon: HeroIcons.envelope,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 5),
                          child: Text("Güvenlik sebepleri nedeniyle email adresini şuanlık değiştiremiyorsun :/", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontSize: 14,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF3b61dc),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: BorderSide(width: 0, color: Color(0xFF3b61dc))
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Kaydet", style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 30),
                          child: Text("Güvenlik Bilgilerin", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Text("Mevcut Şifren", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontSize: 15,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: AppInput(
                          controller: _currentPassword,
                          filled: true,
                          hintText: "Mevcut Şifren",
                          prefixIcon: Iconsax.password_check_outline,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Text("Yeni Şifren", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontSize: 15,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: AppInput(
                          controller: _newPassword,
                          filled: true,
                          hintText: "Yeni Şifren",
                          prefixIcon: Iconsax.password_check_outline,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Text("Yeni Şifreni Tekrarla", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            fontSize: 15,
                          ), textAlign: TextAlign.start,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: AppInput(
                          controller: _newPasswordAgain,
                          filled: true,
                          hintText: "Yeni Şifreni Tekrarla",
                          prefixIcon: Iconsax.password_check_outline,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF3b61dc),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: BorderSide(width: 0, color: Color(0xFF3b61dc))
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Güncelle", style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showThemeSettingsModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.25,
          widthFactor: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 40),
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                      child: Text("Tema Ayarları", style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          textStyle: Theme.of(context).textTheme.bodyLarge
                      ),)
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                      child: Text("Uygulama Görünümü", style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          textStyle: Theme.of(context).textTheme.labelSmall
                      ),)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ToggleSwitch(
                      animate: true,
                      animationDuration: 150,
                      fontSize: 20,
                      minWidth: 100.0,
                      minHeight: 45.0,
                      borderWidth: 1,
                      borderColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                      activeFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.black : Colors.white,
                      inactiveBgColor: Colors.transparent,
                      inactiveFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black,
                      customTextStyles: [GoogleFonts.raleway(fontSize: 16)],
                      activeBgColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                      initialLabelIndex: _settingsProvider?.appSettings?.theme == "dark" ? 0 : 1,
                      totalSwitches: 2,
                      labels: ['Koyu', 'Açık'],
                      onToggle: (index) {
                        _settingsProvider?.setTheme(index == 0 ? "dark" : "light");
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLanguageSettingsModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.25,
          widthFactor: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 40),
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                      child: Text("Dil Ayarları", style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          textStyle: Theme.of(context).textTheme.bodyLarge
                      ),)
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                      child: Text("Uygulama Dili", style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          textStyle: Theme.of(context).textTheme.labelSmall
                      ),)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ToggleSwitch(
                      animate: true,
                      animationDuration: 150,
                      fontSize: 20,
                      minWidth: 100.0,
                      minHeight: 45.0,
                      borderWidth: 1,
                      borderColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                      activeFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.black : Colors.white,
                      inactiveBgColor: Colors.transparent,
                      inactiveFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black,
                      customTextStyles: [GoogleFonts.raleway(fontSize: 16)],
                      activeBgColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                      initialLabelIndex: _settingsProvider?.appSettings?.language == "tr" ? 0 : 1,
                      totalSwitches: 2,
                      labels: ['Türkçe', 'İngilizce'],
                      onToggle: (index) {
                        _settingsProvider?.setLanguage(index == 0 ? "tr" : "en");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFontSizeSettingsModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter modalSetState) {
          return FractionallySizedBox(
            heightFactor: 0.25,
            widthFactor: 1,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 40),
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                        child: Text("Yazı Boyutu", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                        ),)
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                        child: Text("Font Boyutunu Ayarlayın", style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            textStyle: Theme.of(context).textTheme.labelSmall
                        ),)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Slider(
                        activeColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Color(0xFF282828),
                        inactiveColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFF282828).withOpacity(0.2),
                        value: slidingValue,
                        max: 24,
                        min: 16,
                        divisions: 4,
                        label: slidingValue.round().toString(),
                        onChanged: (double value) {
                          modalSetState(() {
                            slidingValue = value;
                          });

                          setState(() {
                            slidingValue = value;
                          });

                          _settingsProvider?.setFontSize(value.toInt());
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("$slidingValue", style: GoogleFonts.raleway(fontSize: 20),),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _showNotificationSettingsModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.25,
          widthFactor: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 40),
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                      child: Text("Bildirim Ayarları", style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          textStyle: Theme.of(context).textTheme.bodyLarge
                      ),)
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                      child: Text("Bildirim", style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          textStyle: Theme.of(context).textTheme.labelSmall
                      ),)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ToggleSwitch(
                      animate: true,
                      animationDuration: 150,
                      fontSize: 20,
                      minWidth: 100.0,
                      minHeight: 45.0,
                      borderWidth: 1,
                      borderColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                      activeFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.black : Colors.white,
                      inactiveBgColor: Colors.transparent,
                      inactiveFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black,
                      customTextStyles: [GoogleFonts.raleway(fontSize: 16)],
                      activeBgColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                      initialLabelIndex: _settingsProvider?.appSettings!.notificationSettings == true ? 1 : 0 ,
                      totalSwitches: 2,
                      labels: ['Hayır', 'Evet'],
                      onToggle: (index) {
                        _settingsProvider?.setNotification(index == 0 ? false : true);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _settingsProvider = context.watch<SettingsProvider>();

    return AppWrapper(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 0, right: 20, left: 20),
              child: Text("Ayarlar", style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w900,
                  fontSize: 36
              ),)
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text("Kullanıcı Ayarların!", style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 14
              ),)
          ),

          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 5),
              child: Text("Hesap Ayarları", style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  fontSize: 17
              ),)
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5, bottom: 10, right: 20, left: 20),
            decoration: BoxDecoration(
              color: _settingsProvider?.appSettings?.theme == "dark" ? Color(0xFF1f1f1f) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)))
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showProfileModal();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage("assets/images/default_profile_image.jpg")
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 20, top: 0, bottom: 0),
                                  child: Text("Emirkan Acar", style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),)
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                                  child: Text("emirkanacar@outlook.com.tr", style: GoogleFonts.raleway(
                                    textStyle: Theme.of(context).textTheme.labelSmall,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),)
                              ),
                            ],
                          )
                        ],
                      ),
                      Icon(HeroIcons.chevron_right, size: 24, color: Theme.of(context).textTheme.bodyLarge?.color)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 5),
              child: Text("Uygulama Ayarları", style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  fontSize: 17
              ),)
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5, bottom: 10, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                SettingsBox(
                  title: "Tema Ayarları",
                  description: "Uygulama Görünümü",
                  icon: HeroIcons.moon,
                  onTap: () {
                    _showThemeSettingsModal();
                  },
                  isFirst: true,
                ),
                SettingsBox(
                  title: "Dil Ayarları",
                  description: "Uygulama Dili",
                  icon: HeroIcons.language,
                  onTap: () {
                    _showLanguageSettingsModal();
                  },
                ),
                SettingsBox(
                  title: "Yazı Boyutu",
                  description: "Yazı Seçenekleri",
                  icon: IonIcons.text,
                  onTap: () {
                    _showFontSizeSettingsModal();
                  },
                ),
                SettingsBox(
                  title: "Bildirim Ayarları",
                  description: "Bildirimler",
                  icon: HeroIcons.bell_alert,
                  onTap: () {
                    _showNotificationSettingsModal();
                  },
                  isLast: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xff000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: BorderSide(width: 0, color: Color(0xff000000))
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text("Çıkış Yap", style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),),
                )
              ),
            ),
          ),
        ]
      ),
    );
  }
}
