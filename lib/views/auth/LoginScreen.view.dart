import 'package:ai_chat/MainScreen.dart';
import 'package:ai_chat/components/AppButton.dart';
import 'package:ai_chat/components/AppInput.dart';
import 'package:ai_chat/helpers/functions.dart';
import 'package:ai_chat/views/auth/RegisterScreen.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgottenEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordHidden = true;
  bool isLoading = false;
  bool isEmailForgottenLoading = false;

  void _showPasswordForgotModal() {
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
                padding: EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 0, right: 20, left: 10),
                              child: Text(AppLocalizations.of(context)!.authPageForgotPasswordTitle, style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w700,
                                  fontSize: getFontSize(22, context).toDouble()
                              ),)
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 20),
                              child: Text(AppLocalizations.of(context)!.authPageForgotPasswordDescription, style: GoogleFonts.raleway(
                                  textStyle: Theme.of(context).textTheme.labelSmall,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(14, context).toDouble()
                              ),)
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 20, top: 10),
                              child: Text(AppLocalizations.of(context)!.authPageForgotPasswordEmail, style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                fontSize: getFontSize(15, context).toDouble(),
                              ), textAlign: TextAlign.start,)
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: AppInput(
                              controller: _forgottenEmailController,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.authPageForgotPasswordEmail,
                              prefixIcon: HeroIcons.envelope,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                            child: AppButton(
                              buttonText: AppLocalizations.of(context)!.authPageForgotPasswordSend,
                              isLoading: isEmailForgottenLoading,
                              onPressed: () {
                                modalSetState(() {
                                  isEmailForgottenLoading = true;
                                });

                                auth.sendPasswordResetEmail(email: _forgottenEmailController.value.text).then((value) {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.success,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.authPageForgotPasswordSuccessTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.authPageForgotPasswordSuccessMessage, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  modalSetState(() {
                                    isEmailForgottenLoading = false;
                                  });

                                  _forgottenEmailController.clear();

                                  Navigator.pop(context);
                                }).catchError((error) {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.authPageForgotPasswordErrorTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.authPageForgotPasswordErrorMessage, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  modalSetState(() {
                                    isEmailForgottenLoading = false;
                                  });
                                });
                              },
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            )
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.authPageLoginTitle, style: GoogleFonts.raleway(
                              fontSize: getFontSize(36, context).toDouble(),
                              fontWeight: FontWeight.w800,
                              textStyle: Theme.of(context).textTheme.bodyLarge
                            ),),
                            Text(AppLocalizations.of(context)!.authPageLoginDescription, style: GoogleFonts.raleway(
                              fontSize: getFontSize(16, context).toDouble(),
                              fontWeight: FontWeight.w500,
                              textStyle: Theme.of(context).textTheme.labelSmall
                            ),),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        height: 128,
                        width: 128,
                        child: Lottie.asset('assets/animations/login_animation.json'),
                      ),
                    ),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppInput(
                        controller: _emailController,
                        filled: true,
                        hintText: AppLocalizations.of(context)!.authPageLoginEmail,
                        prefixIcon: HeroIcons.envelope,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInput(
                        controller: _passwordController,
                        obscureText: _passwordHidden,
                        filled: true,
                        hintText: AppLocalizations.of(context)!.authPageLoginPassword,
                        prefixIcon: Iconsax.password_check_outline,
                        suffixIcon: InkWell(
                          child: _passwordHidden ? Icon(Iconsax.eye_outline, color: Theme.of(context).textTheme.bodyLarge?.color, ) : Icon(Iconsax.eye_slash_outline, color: Theme.of(context).textTheme.bodyLarge?.color,),
                          onTap: () {
                            setState(() {
                              _passwordHidden = !_passwordHidden;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        buttonText: AppLocalizations.of(context)!.authPageLoginButton,
                        isLoading: isLoading,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });

                          AuthCredential credentials = EmailAuthProvider.credential(email: _emailController.value.text, password: _passwordController.value.text);

                          FirebaseAuth.instance.signInWithCredential(credentials).then((value) {
                            toastification.show(
                              context: context,
                              type: ToastificationType.success,
                              style: ToastificationStyle.flatColored,
                              title: Text(AppLocalizations.of(context)!.authPageLoginSuccessTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                              description: Text(AppLocalizations.of(context)!.authPageLoginSuccessMessage, style: GoogleFonts.raleway()),
                              alignment: Alignment.topCenter,
                              autoCloseDuration: const Duration(seconds: 4),
                            );

                            setState(() {
                              isLoading = false;
                            });

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                                    (route) => route.isFirst);
                          }).catchError((error) {
                            toastification.show(
                              context: context,
                              type: ToastificationType.error,
                              style: ToastificationStyle.flatColored,
                              title: Text(AppLocalizations.of(context)!.authPageLoginErrorTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                              description: Text(AppLocalizations.of(context)!.authPageLoginErrorMessage, style: GoogleFonts.raleway()),
                              alignment: Alignment.topCenter,
                              autoCloseDuration: const Duration(seconds: 4),
                            );

                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            AppLocalizations.of(context)!.authPageLoginForgotPassword,
                            style: GoogleFonts.raleway(
                              color: Color(0xFF3b61dc),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF3b61dc),
                              fontSize: getFontSize(16, context).toDouble(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          _showPasswordForgotModal();
                        }
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 20),
                        child: Text(AppLocalizations.of(context)!.authPageLoginDontHaveAccount, style: GoogleFonts.raleway(
                            fontSize: getFontSize(16, context).toDouble(),
                            fontWeight: FontWeight.w500,
                            textStyle: Theme.of(context).textTheme.bodyLarge
                        ),),
                      ),
                      AppButton(
                        buttonText: AppLocalizations.of(context)!.authPageLoginRegisterButton,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                      ),
                    ],
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
