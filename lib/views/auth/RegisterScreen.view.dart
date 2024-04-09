import 'package:ai_chat/views/HomeScreen.view.dart';
import 'package:ai_chat/views/auth/LoginScreen.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFfdfffe),
                  Color(0xffcfdcf6),
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
                              Text('Kayıt Ol', style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700
                              ),),
                              Text('Hesabınızın detaylarına erişin!', style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87
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
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38)
                              )
                          ),
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _passwordHidden,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password_outlined),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38)
                              ),
                              suffixIcon: InkWell(
                                child: _passwordHidden ? const Icon(Icons.remove_red_eye, color: Colors.black,) : const Icon(Icons.remove_red_eye_outlined, color: Colors.black,),
                                onTap: () {
                                  setState(() {
                                    _passwordHidden = !_passwordHidden;
                                  });
                                },
                              )
                          ),
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF3b61dc),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: BorderSide(width: 0, color: Color(0xFF3b61dc))
                          ),
                          onPressed: () async {
                            try {
                              auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                                Fluttertoast.showToast(
                                    msg: "Kayıt işlemi başarılı!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                                );
                              }).catchError((error) {
                                if (error.toString().contains("firebase_auth/email-already-in-use")) {
                                  Fluttertoast.showToast(
                                      msg: "Girilen email zaten kullanılıyor!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Kayıt yapılırken hata oluştu!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Kayıt Ol", style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 20),
                          child: Text('Zaten hesabınız var mı?', style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87
                          ),),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF3b61dc),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: BorderSide(width: 0, color: Color(0xFF3b61dc))
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Giriş Yap", style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),)
                              ],
                            ),
                          ),
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
