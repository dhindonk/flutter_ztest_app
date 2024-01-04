import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_test/data/data/auth_local_datasource.dart';
import 'package:z_test/data/models/auth_model.dart';
import 'package:z_test/presentation/home/pages/dashboard_page.dart';
import 'package:z_test/core/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPage> {
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailLoginFocusNode = FocusNode();
  FocusNode passwordLoginFocusNode = FocusNode();
  FocusNode nameRegisFocusNode = FocusNode();
  FocusNode emailRegisFocusNode = FocusNode();
  FocusNode passRegisFocusNode = FocusNode();

  String selectedItem = 'Login';
  bool cek = false,
      loading = false,
      onClick = true,
      isPasswordObscured = true,
      isPasswordRegistObscured = true;

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordLoginFocusNode.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      loading = !loading;
      onClick = !onClick;
      emailLoginFocusNode.unfocus();
      passRegisFocusNode.unfocus();
    });
    await Future.delayed(Duration(seconds: 2));

    Map<String, dynamic> authResult = await DatabaseHelper.instance.getAuth(
      emailLoginController.text,
      passwordLoginController.text,
    );

    if (authResult.containsKey('auth')) {
      Auth user = authResult['auth'];
      await DatabaseHelper.instance.setToken(user.id!, 1);

      Auth? currentUser = await DatabaseHelper.instance.getCurrentUser();

      if (currentUser != null) {
        Get.off(
          () => Dashboard(user: currentUser),
          transition: Transition.cupertino,
        );

        final snackBar = SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            'Yeayyy.. Berhasil Login',
            style: GoogleFonts.quicksand(
              color: const Color.fromARGB(255, 29, 29, 29),
            ),
          ),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Yahh..Gagal Login',
            style: GoogleFonts.quicksand(),
          ),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      String errorMessage = '';
      if (authResult['error'] == 'email_not_found') {
        errorMessage = 'Email tidak ditemukan';
        emailLoginController.clear();
      } else if (authResult['error'] == 'password_mismatch') {
        errorMessage = 'Password salah';
        passwordLoginController.clear();
      }

      final snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          'Gagal Login: $errorMessage',
          style: GoogleFonts.quicksand(),
        ),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      loading = !loading;
      onClick = !onClick;
    });
  }

  void nextPageRegist() async {
    setState(() {
      loading = !loading;
      onClick = !onClick;
      nameRegisFocusNode.unfocus();
      emailRegisFocusNode.unfocus();
      passRegisFocusNode.unfocus();
    });
    await Future.delayed(Duration(seconds: 2));

    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showErrorMessage('Harap isi semua kolom input');
      // fullNameController.clear();
      // emailController.clear();
      // passwordController.clear();
      setState(() {
        loading = !loading;
        onClick = !onClick;
      });
      return;
    } else if (fullNameController.text.length > 10) {
      showErrorMessage('Nama pengguna maksimal 10 karakter');
      fullNameController.clear();
      setState(() {
        loading = !loading;
        onClick = !onClick;
      });
      return;
    } else if (!emailController.text.endsWith('@gmail.com')) {
      showErrorMessage('Alamat email harus diakhiri dengan "@gmail.com"');
      emailController.clear();
      setState(() {
        loading = !loading;
        onClick = !onClick;
      });
      return;
    } else if (passwordController.text.length < 6) {
      showErrorMessage('Kata sandi minimal 6 karakter');
      passwordController.clear();
      setState(() {
        loading = !loading;
        onClick = !onClick;
      });
      return;
    }

    bool isEmailRegistered = await DatabaseHelper.instance
        .isEmailAlreadyRegistered(emailController.text);

    if (isEmailRegistered) {
      showErrorMessage('Email sudah terdaftar. Silakan gunakan email lain.');
      emailController.clear();
      setState(() {
        loading = !loading;
        onClick = !onClick;
      });
      return;
    }

    Auth newUser = Auth(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      score: 0,
      token: 0,
    );

    int result = await DatabaseHelper.instance.addAuth(newUser);

    if (result != 0) {
      showSuccessMessage('Yeayy.. Register Success');
      emailLoginController.clear();
      passwordLoginController.clear();
      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      selectedItem = 'Login';
      print('result --> ${newUser.token}');

     
      Get.offAll(
        () => LoginPage(),
        transition: Transition.cupertino,
      );

      setState(() {});
    } else {
      showErrorMessage('Gagal mendaftar. Silakan coba lagi.');
    }

    setState(() {
      loading = !loading;
      onClick = !onClick;
    });
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text(
        message,
        style: GoogleFonts.quicksand(
          color: const Color.fromARGB(255, 29, 29, 29),
        ),
      ),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: GoogleFonts.quicksand(),
      ),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void select(String item) {
    selectedItem = item;
    emailLoginFocusNode.unfocus();
    passwordLoginFocusNode.unfocus();
    nameRegisFocusNode.unfocus();
    emailRegisFocusNode.unfocus();
    passRegisFocusNode.unfocus();
    if (isPasswordRegistObscured == false) {
      isPasswordRegistObscured = true;
      setState(() {});
    } else if (isPasswordObscured == false) {
      isPasswordObscured = true;
      setState(() {});
    }
    setState(() {});
  }

  void check() {
    setState(() {
      cek = !cek;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    final fullWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          animType: AnimType.scale,
          title: "Confirm Exit",
          desc: "Are you sure you want to exit?",
          btnCancelOnPress: () {},
          titleTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          descTextStyle: GoogleFonts.quicksand(),
          btnOkOnPress: () {
            Get.back(canPop: true);
            SystemNavigator.pop();
          },
        )..show();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: fullHeight,
            width: fullWidth,
            color: Colors.white,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 180,
                      width: 250,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () => onClick == true
                                      ? select('Login')
                                      : onClick,
                                  child: selectedItem == 'Login'
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              50,
                                          decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Login',
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              50,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              'Login',
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  color: Colors.black12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )),
                              InkWell(
                                  onTap: () =>
                                      (onClick) ? select('Register') : onClick,
                                  child: selectedItem == 'Register'
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              50,
                                          decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              'Register',
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              50,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              'Register',
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  color: Colors.black12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 500,
                      color: Colors.transparent,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          selectedItem == 'Login'
                              ? Positioned(
                                  top: 20,
                                  left: MediaQuery.of(context).size.width / 2 -
                                      150,
                                  child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, left: 25, right: 25),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Welcome Back!',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: primary,
                                                ),
                                              ),
                                              Text(
                                                'Silahkan isi data di bawah',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                controller:
                                                    emailLoginController,
                                                focusNode: emailLoginFocusNode,
                                                decoration: InputDecoration(
                                                    label: Text('Email'),
                                                    labelStyle: TextStyle(
                                                        color: Colors.black45),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none),
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 240, 240, 240)),
                                                onFieldSubmitted: (_) =>
                                                    passwordLoginFocusNode
                                                        .requestFocus(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Stack(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        passwordLoginController,
                                                    focusNode:
                                                        passwordLoginFocusNode,
                                                    obscureText:
                                                        isPasswordObscured,
                                                    decoration: InputDecoration(
                                                        label: Text('Password'),
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black45),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        filled: true,
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                240, 240, 240)),
                                                    onFieldSubmitted: (_) =>
                                                        (onClick)
                                                            ? login()
                                                            : onClick,
                                                  ),
                                                  Positioned(
                                                    right: 15,
                                                    top: 20,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isPasswordObscured =
                                                                !isPasswordObscured;
                                                          });
                                                        },
                                                        child: Icon(
                                                          isPasswordObscured
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color:
                                                              isPasswordObscured
                                                                  ? primary
                                                                  : red,
                                                        )),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(left: 10),
                                        //   child: Row(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.center,
                                        //     children: [
                                        //       Checkbox(
                                        //         value: cek,
                                        //         onChanged: (_) {
                                        //           check();
                                        //         },
                                        //         checkColor: cek == false
                                        //             ? Colors.transparent
                                        //             : Colors.white,
                                        //         fillColor: cek == false
                                        //             ? MaterialStatePropertyAll(
                                        //                 Colors.transparent)
                                        //             : MaterialStatePropertyAll(
                                        //                 primary),
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(50),
                                        //         ),
                                        //         side: cek == false
                                        //             ? BorderSide(color: primary)
                                        //             : BorderSide(
                                        //                 color: Colors.white),
                                        //       ),
                                        //       Text(
                                        //         'Remember me',
                                        //         style: GoogleFonts.quicksand(
                                        //             fontSize: 10,
                                        //             color: cek == false
                                        //                 ? Colors.black54
                                        //                 : primary),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  (onClick) ? login() : onClick,
                                              child: Container(
                                                  width: 150,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: loading == false
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'L O G I N',
                                                              style: GoogleFonts.quicksand(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_right_rounded,
                                                              size: 25,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        )
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              //
                              //
                              //
                              //
                              //
                              // REGISTER
                              // PAGE
                              //
                              //
                              //
                              //
                              //
                              : Positioned(
                                  top: 30,
                                  left: MediaQuery.of(context).size.width / 2 -
                                      150,
                                  child: Container(
                                    width: 300,
                                    // height: 350,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Welcome !!',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: primary,
                                                ),
                                              ),
                                              Text(
                                                'Selamat datang di ZTest.',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                controller: fullNameController,
                                                focusNode: nameRegisFocusNode,
                                                // maxLength: 10,
                                                decoration: InputDecoration(
                                                    label: Text('Nickname'),
                                                    labelStyle: TextStyle(
                                                        color: Colors.black45),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none),
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 240, 240, 240)),
                                                onFieldSubmitted: (_) =>
                                                    emailRegisFocusNode
                                                        .requestFocus(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                controller: emailController,
                                                focusNode: emailRegisFocusNode,
                                                decoration: InputDecoration(
                                                    label: Text('Email'),
                                                    labelStyle: TextStyle(
                                                        color: Colors.black45),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none),
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 240, 240, 240)),
                                                onFieldSubmitted: (_) =>
                                                    passRegisFocusNode
                                                        .requestFocus(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Stack(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        passwordController,
                                                    focusNode:
                                                        passRegisFocusNode,
                                                    obscureText:
                                                        isPasswordRegistObscured,
                                                    decoration: InputDecoration(
                                                      label: Text('Password'),
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.black45),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      filled: true,
                                                      fillColor: Color.fromARGB(
                                                          255, 240, 240, 240),
                                                    ),
                                                    onFieldSubmitted: (_) =>
                                                        onClick
                                                            ? nextPageRegist()
                                                            : onClick,
                                                  ),
                                                  Positioned(
                                                    right: 15,
                                                    top: 20,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isPasswordRegistObscured =
                                                                !isPasswordRegistObscured;
                                                          });
                                                        },
                                                        child: Icon(
                                                          isPasswordRegistObscured
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color:
                                                              isPasswordRegistObscured
                                                                  ? primary
                                                                  : red,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () => (onClick)
                                                  ? nextPageRegist()
                                                  : onClick,
                                              child: Container(
                                                  width: 180,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: loading == false
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'R E G I S T',
                                                              style: GoogleFonts.quicksand(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_right_rounded,
                                                              size: 25,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        )
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  PopScope(
//   canPop: true,
//   onPopInvoked: (didPop) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.question,
//       animType: AnimType.scale,
//       title: "Confirm Exit",
//       desc: "Are you sure you want to exit?",
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {
//         Navigator.of(context).pop(true);
//         SystemNavigator.pop();
//       },
//     )..show();
//   },
