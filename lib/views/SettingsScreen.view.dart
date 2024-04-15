import 'package:ai_chat/components/AppButton.dart';
import 'package:ai_chat/helpers/functions.dart';
import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/AppInput.dart';
import '../components/AppWrapper.dart';
import '../components/SettingsBox.dart';
import 'auth/LoginScreen.view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _newPasswordAgain = TextEditingController();

  final TextEditingController _loginEmail = TextEditingController();
  final TextEditingController _loginPassword = TextEditingController();

  FirebaseAuth? firebaseAuth;
  String? userDisplayName;

  SettingsProvider? _settingsProvider;
  double slidingValue = 16;

  bool actionIsLoading = false;
  bool isNameLoading = false;
  bool isPasswordLoading = false;
  bool reAuthenticateLoading = false;

  @override
  void initState() {
    _settingsProvider = context.read<SettingsProvider>();
    slidingValue = _settingsProvider?.appSettings?.fontSize.toDouble() ?? 16;
    firebaseAuth = FirebaseAuth.instance;

    userDisplayName = firebaseAuth?.currentUser?.displayName;

    super.initState();
  }

  void _showProfileModal() {
    _emailController.text = firebaseAuth?.currentUser?.email ?? "";
    _firstNameController.text = firebaseAuth?.currentUser?.displayName ?? "";

    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              widthFactor: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 24,
                          backgroundImage: firebaseAuth?.currentUser?.photoURL != null ?
                          NetworkImage(firebaseAuth?.currentUser?.photoURL.toString() ?? "") as ImageProvider : const AssetImage("assets/images/default_profile_image.jpg")
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                              child: Text(firebaseAuth?.currentUser?.displayName ?? "", style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w700,
                                  fontSize: getFontSize(20, context).toDouble()
                              ),)
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 0),
                              child: Text(firebaseAuth?.currentUser?.email ?? "", style: GoogleFonts.raleway(
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontWeight: FontWeight.w400,
                                fontSize: getFontSize(15, context).toDouble(),
                              ),)
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 30),
                              child: Text(AppLocalizations.of(context)!.settingsPagePersonalInfoTitle, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w700,
                                fontSize: getFontSize(17, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                              child: Text(AppLocalizations.of(context)!.settingsPageNameSurname, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(15, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _firstNameController,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.settingsPageNameSurname,
                              prefixIcon: HeroIcons.user,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                              child: Text(AppLocalizations.of(context)!.settingsPageEmail, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(15, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _emailController,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.settingsPageEmail,
                              prefixIcon: HeroIcons.envelope,
                              readOnly: true,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 5),
                              child: Text(AppLocalizations.of(context)!.settingsPageEmailDescription, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w500,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(14, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: AppButton(
                              buttonText: AppLocalizations.of(context)!.settingsPageSaveButton,
                              onPressed: () {
                                modalSetState(() {
                                  isNameLoading = true;
                                });

                                if (_firstNameController.value.text.length > 3) {
                                  firebaseAuth?.currentUser?.updateDisplayName(_firstNameController.value.text).then((value) {

                                    modalSetState(() {
                                      firebaseAuth?.currentUser?.reload();
                                      isNameLoading = false;
                                      userDisplayName = _firstNameController.value.text;
                                    });

                                    setState(() {
                                      userDisplayName = _firstNameController.value.text;
                                    });

                                    Navigator.pop(context);

                                    toastification.show(
                                      context: context,
                                      type: ToastificationType.success,
                                      style: ToastificationStyle.flatColored,
                                      title: Text(AppLocalizations.of(context)!.settingsPageNameUpdateSuccess, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                      description: Text(AppLocalizations.of(context)!.settingsPageNameUpdateSuccessMessage, style: GoogleFonts.raleway()),
                                      alignment: Alignment.topCenter,
                                      autoCloseDuration: const Duration(seconds: 4),
                                    );
                                  }).catchError((error) {
                                    toastification.show(
                                      context: context,
                                      type: ToastificationType.error,
                                      style: ToastificationStyle.flatColored,
                                      title: Text(AppLocalizations.of(context)!.settingsPageNameUpdateError, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                      description: Text(AppLocalizations.of(context)!.settingsPageNameUpdateErrorMessage, style: GoogleFonts.raleway()),
                                      alignment: Alignment.topCenter,
                                      autoCloseDuration: const Duration(seconds: 4),
                                    );

                                    modalSetState(() {
                                      isNameLoading = false;
                                    });
                                  });
                                } else {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.settingsPageNameUpdateError, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.settingsPageNameUpdateShortError, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  modalSetState(() {
                                    isNameLoading = false;
                                  });
                                }
                              },
                              isLoading: isNameLoading,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 30),
                              child: Text(AppLocalizations.of(context)!.settingsPageSecurityInfoTitle, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w700,
                                fontSize: getFontSize(17, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _newPassword,
                              filled: true,
                              obscureText: true,
                              hintText: AppLocalizations.of(context)!.settingsPageNewPassword,
                              prefixIcon: Iconsax.password_check_outline,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                              child: Text(AppLocalizations.of(context)!.settingsPageNewPasswordAgain, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(15, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _newPasswordAgain,
                              filled: true,
                              obscureText: true,
                              hintText: AppLocalizations.of(context)!.settingsPageNewPasswordAgain,
                              prefixIcon: Iconsax.password_check_outline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: AppButton(
                              buttonText: AppLocalizations.of(context)!.settingsPageSaveButton,
                              onPressed: () {
                                modalSetState(() {
                                  isPasswordLoading = true;
                                });

                                if (_newPassword.value.text != _newPasswordAgain.value.text) {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.settingsPagePasswordError, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.settingsPagePasswordMatchErrorMessage, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  modalSetState(() {
                                    isPasswordLoading = false;
                                  });
                                }else if (_newPassword.value.text.length < 8) {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.settingsPagePasswordError, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.settingsPagePasswordShortErrorMessage, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  modalSetState(() {
                                    isPasswordLoading = false;
                                  });
                                } else {
                                  firebaseAuth?.currentUser?.updatePassword(_newPassword.value.text).then((value) {

                                    modalSetState(() {
                                      firebaseAuth?.currentUser?.reload();
                                      isPasswordLoading = true;
                                    });

                                    _newPassword.clear();
                                    _newPasswordAgain.clear();

                                    Navigator.pop(context);

                                    toastification.show(
                                      context: context,
                                      type: ToastificationType.success,
                                      style: ToastificationStyle.flatColored,
                                      title: Text(AppLocalizations.of(context)!.settingsPagePasswordSuccess, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                      description: Text(AppLocalizations.of(context)!.settingsPagePasswordSuccessMessage, style: GoogleFonts.raleway()),
                                      alignment: Alignment.topCenter,
                                      autoCloseDuration: const Duration(seconds: 4),
                                    );
                                  }).catchError((error) {
                                    if (error.toString().contains("[firebase_auth/requires-recent-login]")) {
                                      toastification.show(
                                        context: context,
                                        type: ToastificationType.info,
                                        style: ToastificationStyle.flatColored,
                                        title: Text(AppLocalizations.of(context)!.settingsPagePasswordInfo, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                        description: Text(AppLocalizations.of(context)!.settingsPagePasswordSessionErrorMessage, style: GoogleFonts.raleway()),
                                        alignment: Alignment.topCenter,
                                        autoCloseDuration: const Duration(seconds: 4),
                                      );

                                      _showReAuthenticateUserModal();

                                      modalSetState(() {
                                        isPasswordLoading = true;
                                      });

                                    } else {
                                      toastification.show(
                                        context: context,
                                        type: ToastificationType.error,
                                        style: ToastificationStyle.flatColored,
                                        title: Text(AppLocalizations.of(context)!.settingsPagePasswordError, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                        description: Text(AppLocalizations.of(context)!.settingsPagePasswordErrorMessage, style: GoogleFonts.raleway()),
                                        alignment: Alignment.topCenter,
                                        autoCloseDuration: const Duration(seconds: 4),
                                      );

                                      modalSetState(() {
                                        isPasswordLoading = true;
                                      });
                                    }
                                  });
                                }
                              },
                              isLoading: isPasswordLoading,
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
      },
    );
  }

  void _showReAuthenticateUserModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              widthFactor: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 0, right: 20, left: 10),
                              child: Text("${AppLocalizations.of(context)!.settingsReAuthenticateTitle}, ${firebaseAuth?.currentUser?.displayName}", style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(22, context).toDouble()
                              ),)
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 20),
                              child: Text(AppLocalizations.of(context)!.settingsReAuthenticateDesc, style: GoogleFonts.raleway(
                                  textStyle: Theme.of(context).textTheme.labelSmall,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(14, context).toDouble()
                              ),)
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                              child: Text(AppLocalizations.of(context)!.settingsPageEmail, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(15, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _loginEmail,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.settingsPageEmail,
                              prefixIcon: HeroIcons.envelope,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                              child: Text(AppLocalizations.of(context)!.settingsReAuthenticatePassword, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(15, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _loginPassword,
                              filled: true,
                              obscureText: true,
                              hintText: AppLocalizations.of(context)!.settingsReAuthenticatePassword,
                              prefixIcon: Iconsax.password_check_outline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: AppButton(
                              buttonText: AppLocalizations.of(context)!.settingsReAuthenticateButton,
                              onPressed: () {
                                  modalSetState(() {
                                    reAuthenticateLoading = true;
                                  });

                                  AuthCredential credentials = EmailAuthProvider.credential(email: _loginEmail.value.text, password: _loginPassword.value.text);

                                  firebaseAuth?.currentUser?.reauthenticateWithCredential(credentials).then((value) {
                                    Navigator.pop(context);

                                    _loginEmail.clear();
                                    _loginPassword.clear();

                                    modalSetState(() {
                                      reAuthenticateLoading = false;
                                    });

                                    toastification.show(
                                      context: context,
                                      type: ToastificationType.success,
                                      style: ToastificationStyle.flatColored,
                                      title: Text(AppLocalizations.of(context)!.settingsReAuthenticateSuccess, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                      description: Text(AppLocalizations.of(context)!.settingsReAuthenticateSuccessMessage, style: GoogleFonts.raleway()),
                                      alignment: Alignment.topCenter,
                                      autoCloseDuration: const Duration(seconds: 4),
                                    );
                                  }).catchError((error) {
                                    toastification.show(
                                      context: context,
                                      type: ToastificationType.error,
                                      style: ToastificationStyle.flatColored,
                                      title: Text(AppLocalizations.of(context)!.settingsReAuthenticateError, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                      description: Text(AppLocalizations.of(context)!.settingsReAuthenticateErrorMessage, style: GoogleFonts.raleway()),
                                      alignment: Alignment.topCenter,
                                      autoCloseDuration: const Duration(seconds: 4),
                                    );

                                    modalSetState(() {
                                      reAuthenticateLoading = false;
                                    });
                                  });
                                },
                              isLoading: reAuthenticateLoading,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return FractionallySizedBox(
              heightFactor: 0.25,
              widthFactor: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                          child: Text(AppLocalizations.of(context)!.settingsPageThemeTitle, style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                              fontSize: getFontSize(20, context).toDouble(),
                              textStyle: Theme.of(context).textTheme.bodyLarge
                          ),)
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20, top: 0),
                          child: Text(AppLocalizations.of(context)!.settingsPageThemeDescription, style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w400,
                              fontSize: getFontSize(15, context).toDouble(),
                              textStyle: Theme.of(context).textTheme.labelSmall
                          ),)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ToggleSwitch(
                          animate: true,
                          animationDuration: 150,
                          fontSize: getFontSize(20, context).toDouble(),
                          minWidth: 100.0,
                          minHeight: 45.0,
                          borderWidth: 1,
                          borderColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                          activeFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.black : Colors.white,
                          inactiveBgColor: Colors.transparent,
                          inactiveFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black,
                          customTextStyles: [GoogleFonts.raleway(fontSize: getFontSize(16, context).toDouble())],
                          activeBgColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                          initialLabelIndex: _settingsProvider?.appSettings?.theme == "dark" ? 0 : 1,
                          totalSwitches: 2,
                          labels: [AppLocalizations.of(context)!.settingsPageThemeDark, AppLocalizations.of(context)!.settingsPageThemeLight],
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
      },
    );
  }

  void _showLanguageSettingsModal() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return FractionallySizedBox(
              heightFactor: 0.25,
              widthFactor: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                          child: Text(AppLocalizations.of(context)!.settingsPageLangTitle, style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                              fontSize: getFontSize(20, context).toDouble(),
                              textStyle: Theme.of(context).textTheme.bodyLarge
                          ),)
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20, top: 0),
                          child: Text(AppLocalizations.of(context)!.settingsPageLangDescription, style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w400,
                              fontSize: getFontSize(15, context).toDouble(),
                              textStyle: Theme.of(context).textTheme.labelSmall
                          ),)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ToggleSwitch(
                          animate: true,
                          animationDuration: 150,
                          fontSize: getFontSize(20, context).toDouble(),
                          minWidth: 100.0,
                          minHeight: 45.0,
                          borderWidth: 1,
                          borderColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                          activeFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.black : Colors.white,
                          inactiveBgColor: Colors.transparent,
                          inactiveFgColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black,
                          customTextStyles: [GoogleFonts.raleway(fontSize: getFontSize(16, context).toDouble())],
                          activeBgColor: [_settingsProvider?.appSettings?.theme == "dark" ? Colors.white : Colors.black],
                          initialLabelIndex: _settingsProvider?.appSettings?.language == "tr" ? 0 : 1,
                          totalSwitches: 2,
                          labels: [AppLocalizations.of(context)!.settingsPageLangTurkish, AppLocalizations.of(context)!.settingsPageLangEnglish],
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
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 0),
                        child: Text(AppLocalizations.of(context)!.settingsPageFontTitle, style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: getFontSize(20, context).toDouble()
                        ),)
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20, top: 0),
                        child: Text(AppLocalizations.of(context)!.settingsPageFontModalDescription, style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w400,
                            fontSize: getFontSize(15, context).toDouble(),
                            textStyle: Theme.of(context).textTheme.labelSmall
                        ),)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Slider(
                        activeColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white : const Color(0xFF282828),
                        inactiveColor: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white24 : const Color(0xFF282828).withOpacity(0.2),
                        value: slidingValue,
                        max: 18,
                        min: 14,
                        divisions: 2,
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
                      padding: const EdgeInsets.only(top: 10),
                      child: slidingValue == 14 ? Text(AppLocalizations.of(context)!.settingsPageFontSmaller, style: GoogleFonts.raleway(fontSize: getFontSize(20, context).toDouble()),) : slidingValue == 16 ? Text(AppLocalizations.of(context)!.settingsPageFontMedium, style: GoogleFonts.raleway(fontSize: getFontSize(20, context).toDouble()),) : Text(AppLocalizations.of(context)!.settingsPageFontLarger, style: GoogleFonts.raleway(fontSize: getFontSize(20, context).toDouble()),)
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

  @override
  Widget build(BuildContext context) {
    _settingsProvider = context.watch<SettingsProvider>();

    return AppWrapper(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
              child: Text(AppLocalizations.of(context)!.settingsPageTitle, style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w900,
                  fontSize: getFontSize(36, context).toDouble()
              ),)
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(AppLocalizations.of(context)!.settingsPageDescription, style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: getFontSize(14, context).toDouble(),
                  textStyle: Theme.of(context).textTheme.labelSmall
              ),)
          ),

          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 5),
              child: Text(AppLocalizations.of(context)!.settingsPageAccountSettings, style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(17, context).toDouble()
              ),)
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5, bottom: 10, right: 20, left: 20),
            decoration: BoxDecoration(
              color: _settingsProvider?.appSettings?.theme == "dark" ? const Color(0xFF1f1f1f) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: _settingsProvider?.appSettings?.theme == "dark" ? Colors.white24 : const Color(0xFFC9C9C9)))
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showProfileModal();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 24,
                              backgroundImage: firebaseAuth?.currentUser?.photoURL != null ?
                                  NetworkImage(firebaseAuth?.currentUser?.photoURL.toString() ?? "") as ImageProvider : const AssetImage("assets/images/default_profile_image.jpg")
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20, top: 0, bottom: 0),
                                  child: Text(userDisplayName ?? "", style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w600,
                                      fontSize: getFontSize(16, context).toDouble()
                                  ),)
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20, top: 0),
                                  child: Text(firebaseAuth?.currentUser?.email ?? "", style: GoogleFonts.raleway(
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 5),
              child: Text(AppLocalizations.of(context)!.settingsPageAccountSettings, style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(17, context).toDouble()
              ),)
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5, bottom: 10, right: 20, left: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                SettingsBox(
                  title: AppLocalizations.of(context)!.settingsPageThemeTitle,
                  description: AppLocalizations.of(context)!.settingsPageThemeDescription,
                  icon: HeroIcons.moon,
                  onTap: () {
                    _showThemeSettingsModal();
                  },
                  isFirst: true,
                ),
                SettingsBox(
                  title: AppLocalizations.of(context)!.settingsPageLangTitle,
                  description: AppLocalizations.of(context)!.settingsPageLangDescription,
                  icon: HeroIcons.language,
                  onTap: () {
                    _showLanguageSettingsModal();
                  },
                ),
                SettingsBox(
                  title: AppLocalizations.of(context)!.settingsPageFontTitle,
                  description: AppLocalizations.of(context)!.settingsPageFontDescription,
                  icon: IonIcons.text,
                  onTap: () {
                    _showFontSizeSettingsModal();
                  },
                  isLast: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: const BorderSide(width: 0, color: Color(0xff000000))
              ),
              onPressed: () {
                firebaseAuth?.signOut().then((value) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.success,
                    style: ToastificationStyle.flatColored,
                    title: Text(AppLocalizations.of(context)!.settingsPageLogoutSuccessTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                    description: Text(AppLocalizations.of(context)!.settingsPageLogoutSuccessMessage, style: GoogleFonts.raleway()),
                    alignment: Alignment.topCenter,
                    autoCloseDuration: const Duration(seconds: 4),
                  );

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                          (route) => route.isFirst);
                }).catchError((error) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    style: ToastificationStyle.flatColored,
                    title: Text(AppLocalizations.of(context)!.settingsPageLogoutErrorTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                    description: Text(AppLocalizations.of(context)!.settingsPageLogoutErrorMessage, style: GoogleFonts.raleway()),
                    alignment: Alignment.topCenter,
                    autoCloseDuration: const Duration(seconds: 4),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(AppLocalizations.of(context)!.settingsPageLogout, style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: getFontSize(15, context).toDouble()
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
