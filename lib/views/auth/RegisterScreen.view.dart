import 'package:ai_chat/MainScreen.dart';
import 'package:ai_chat/components/AppButton.dart';
import 'package:ai_chat/components/AppInput.dart';
import 'package:ai_chat/views/auth/LoginScreen.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordHidden = true;
  bool isLoading = false;

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
                              Text(AppLocalizations.of(context)!.authPageRegisterTitle, style: GoogleFonts.raleway(
                                  fontSize: getFontSize(36, context).toDouble(),
                                  fontWeight: FontWeight.w800,
                                  textStyle: Theme.of(context).textTheme.bodyLarge
                              ),),
                              Text(AppLocalizations.of(context)!.authPageRegisterDescription, style: GoogleFonts.raleway(
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
                          hintText: AppLocalizations.of(context)!.authPageRegisterEmail,
                          prefixIcon: HeroIcons.envelope
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppInput(
                          controller: _passwordController,
                          obscureText: _passwordHidden,
                          hintText: AppLocalizations.of(context)!.authPageRegisterPassword,
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
                          buttonText: AppLocalizations.of(context)!.authPageRegisterButton,
                          isLoading: isLoading,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                                toastification.show(
                                  context: context,
                                  type: ToastificationType.success,
                                  style: ToastificationStyle.flatColored,
                                  title: Text(AppLocalizations.of(context)!.authPageRegisterSuccessTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                  description: Text(AppLocalizations.of(context)!.authPageRegisterSuccessMessage, style: GoogleFonts.raleway()),
                                  alignment: Alignment.topCenter,
                                  autoCloseDuration: const Duration(seconds: 4),
                                );

                                setState(() {
                                  isLoading = false;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainScreen()),
                                );
                              }).catchError((error) {
                                if (error.toString().contains("firebase_auth/email-already-in-use")) {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.authPageRegisterEmailErrorTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.authPageRegisterEmailErrorMessage, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.flatColored,
                                    title: Text(AppLocalizations.of(context)!.authPageRegisterErrorTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                    description: Text(AppLocalizations.of(context)!.authPageRegisterErrorMessage, style: GoogleFonts.raleway()),
                                    alignment: Alignment.topCenter,
                                    autoCloseDuration: const Duration(seconds: 4),
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            } catch (e) {
                              toastification.show(
                                context: context,
                                type: ToastificationType.error,
                                style: ToastificationStyle.flatColored,
                                title: Text(AppLocalizations.of(context)!.authPageRegisterErrorTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w700),),
                                description: Text(AppLocalizations.of(context)!.authPageRegisterErrorMessage, style: GoogleFonts.raleway()),
                                alignment: Alignment.topCenter,
                                autoCloseDuration: const Duration(seconds: 4),
                              );

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 20),
                          child: Text(AppLocalizations.of(context)!.authPageRegisterAlreadyHaveAccount, style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textStyle: Theme.of(context).textTheme.bodyLarge
                          ),),
                        ),
                        AppButton(
                          buttonText: AppLocalizations.of(context)!.authPageRegisterLoginButton,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                        )
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
