import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_test/data/data/auth_local_datasource.dart';
import 'package:z_test/presentation/auth/pages/login_register_page.dart';
import 'package:z_test/presentation/home/pages/dashboard_page.dart';
import 'package:z_test/core/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/auth_model.dart';

class ProfilePage extends StatefulWidget {
  final Auth user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FocusNode nameEditFocusNode = FocusNode();
  FocusNode emailEditFocusNode = FocusNode();
  FocusNode passEditFocusNode = FocusNode();

  String selectedItem = 'Lihat';
  String? pathImages;
  bool loading = false, loading2 = false, exit = false, _onClick = true;
  String? isImage;

  //
  void select(String item) {
    selectedItem = item;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() {
    namaController.text = widget.user.fullName!;
    emailController.text = widget.user.email!;
    passController.text = widget.user.password!;
    print('-------------ID-------------===');
    print(widget.user.id);
    print('--------------------------===');
    print('--------- IMG -------------===');
    print(widget.user.image);
    print('----------PATH IMG-------------===');
    if (widget.user.image != null) {
      isImage = widget.user.image;
      pathImages = widget.user.image;

      print(pathImages);
    }
    print('<> -------------------------- <>');
  }

  void hapusAccount() async {
    setState(() {
      loading2 = !loading2;
      _onClick = !_onClick;
    });
    await Future.delayed(Duration(seconds: 2));
    await DatabaseHelper.instance.removeAuth(widget.user.id!);

    Get.off(
      LoginPage(),
      transition: Transition.cupertino,
    );
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        'AKUN DIHAPUS!!',
        style: GoogleFonts.quicksand(
          color: Colors.white,
        ),
      ),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      loading2 = !loading2;
      _onClick = !_onClick;
    });
  }

  void confirmDelete() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      title: "Confirm Delete",
      desc: "Are you sure you want to delete account?",
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        hapusAccount();
      },
    )..show();
  }

  void editProfile(bool isLogout) async {
    setState(() {
      loading = !loading;
      _onClick = !_onClick;
      nameEditFocusNode.unfocus();
      emailEditFocusNode.unfocus();
      passEditFocusNode.unfocus();
    });

    await Future.delayed(Duration(seconds: 2));

    if (selectedItem == 'Edit') {
      if (namaController.text.isEmpty ||
          emailController.text.isEmpty ||
          passController.text.isEmpty) {
        showErrorMessage('Harap isi semua kolom input');
      } else if (namaController.text.length > 10) {
        showErrorMessage('Nama pengguna maksimal 10 karakter');
        namaController.clear();
      } else if (!emailController.text.endsWith('@gmail.com')) {
        showErrorMessage('Alamat email harus diakhiri dengan "@gmail.com"');
        emailController.clear();
      } else if (passController.text.length < 6) {
        showErrorMessage('Kata sandi minimal 6 karakter');
        passController.clear();
      } else {
        Auth updatedProfile = Auth(
          id: widget.user.id,
          fullName: namaController.text,
          email: emailController.text,
          password: passController.text,
          image: pathImages,
          score: widget.user.score,
          token: widget.user.token,
        );

        await DatabaseHelper.instance.updateAuth(updatedProfile);
        if (isLogout == true) {
          Get.offAll(
            () => LoginPage(),
            transition: Transition.cupertino,
          );

          final snackBar = SnackBar(
            backgroundColor: kuning,
            content: Text(
              'Logout berhasil',
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 29, 29, 29),
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          Get.off(
            () => Dashboard(user: updatedProfile),
            transition: Transition.cupertino,
          );
          final snackBar = SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              'Berhasil Edit Profile',
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
      }
    }

    setState(() {
      selectedItem = (selectedItem == 'Lihat') ? 'Edit' : 'Lihat';
      loading = !loading;
      _onClick = !_onClick;
    });
  }

  void imgFromCamera() async {
    XFile? pickedImg = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear,
    );

    pathImages = pickedImg!.path;
    isImage = pathImages;
    setState(() {});
  }

  void imgFromGallery() async {
    XFile? pickedImg = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    pathImages = pickedImg!.path;
    isImage = pathImages;
    setState(() {});
  }

  void showPicker(context) {
    showModalBottomSheet(
      backgroundColor: trans,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          // height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: gray,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Foto Profile',
                      style: GoogleFonts.quicksand(
                        color: primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: trans,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      imgFromCamera();
                      Get.back();
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: primary,
                            radius: 25,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: white,
                            ),
                          ),
                          Text(
                            'Kamera',
                            style: GoogleFonts.quicksand(
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imgFromGallery();
                      Get.back();
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: primary,
                            radius: 25,
                            child: Icon(
                              Icons.photo_rounded,
                              color: white,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: GoogleFonts.quicksand(
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
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

  void tapLogout() async {
    // exit = !exit;
    // _onClick = !_onClick;
    // setState(() {});
    // await Future.delayed(Duration(seconds: 1));
    // await DatabaseHelper.instance.setToken(widget.user.id!, 0);

    // Get.offAll(
    //   () => LoginPage(),
    //   transition: Transition.cupertino,
    // );
    // exit = !exit;
    // _onClick = !_onClick;
    // setState(() {});
    final nickName = namaController.text;
    final email = emailController.text;
    final password = passController.text;
    nameEditFocusNode.unfocus();
    emailEditFocusNode.unfocus();
    passEditFocusNode.unfocus();
    print(
        '---> path ${pathImages}| user.image ${widget.user.image} <--- ${nickName} | ${email} | ${password}');
    setState(() {});

    if (pathImages == widget.user.image &&
        nickName == widget.user.fullName &&
        email == widget.user.email &&
        password == widget.user.password) {
      exit = !exit;
      _onClick = !_onClick;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      await DatabaseHelper.instance.setToken(widget.user.id!, 0);

      Get.offAll(
        () => LoginPage(),
        transition: Transition.cupertino,
      );
      final snackBar = SnackBar(
        backgroundColor: kuning,
        content: Text(
          'Logout berhasil',
          style: GoogleFonts.quicksand(
            color: const Color.fromARGB(255, 29, 29, 29),
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      exit = !exit;
      _onClick = !_onClick;
      setState(() {});
    } else {
      if (pathImages == widget.user.image) {
        print('path sama');
        if (nickName == widget.user.fullName) {
          print('nama sama');
          if (email == widget.user.email) {
            print('email sama');
            if (password == widget.user.password) {
              print('password sama');
              // return true;
            } else {
              print('password beda');
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.scale,
                title: "Confirm Logout?",
                desc: "Perubahan tidak akan disimpan!",
                titleTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
                descTextStyle: GoogleFonts.quicksand(),
                btnCancelOnPress: () async {},
                btnOkOnPress: () async {
                  exit = !exit;
                  _onClick = !_onClick;
                  setState(() {});
                  await Future.delayed(Duration(seconds: 1));
                  await DatabaseHelper.instance.setToken(widget.user.id!, 0);

                  Get.offAll(
                    () => LoginPage(),
                    transition: Transition.cupertino,
                  );
                  final snackBar = SnackBar(
                    backgroundColor: kuning,
                    content: Text(
                      'Logout berhasil',
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 29, 29, 29),
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  exit = !exit;
                  _onClick = !_onClick;
                  setState(() {});
                },
              )
                ..show();
            }
          } else {
            print('email beda');
            await AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              animType: AnimType.scale,
              title: "Confirm Logout?",
              desc: "Perubahan tidak akan disimpan!",
              titleTextStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
              descTextStyle: GoogleFonts.quicksand(),
              btnCancelOnPress: () async {},
              btnOkOnPress: () async {
                exit = !exit;
                _onClick = !_onClick;
                setState(() {});
                await Future.delayed(Duration(seconds: 1));
                await DatabaseHelper.instance.setToken(widget.user.id!, 0);

                Get.offAll(
                  () => LoginPage(),
                  transition: Transition.cupertino,
                );
                final snackBar = SnackBar(
                  backgroundColor: kuning,
                  content: Text(
                    'Logout berhasil',
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 29, 29, 29),
                    ),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                exit = !exit;
                _onClick = !_onClick;
                setState(() {});
              },
            )
              ..show();
            // return false;
          }
        } else {
          print('nama berubah');
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.scale,
            title: "Confirm Logout?",
            desc: "Perubahan tidak akan disimpan!",
            titleTextStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
            descTextStyle: GoogleFonts.quicksand(),
            btnCancelOnPress: () async {},
            btnOkOnPress: () async {
              exit = !exit;
              _onClick = !_onClick;
              setState(() {});
              await Future.delayed(Duration(seconds: 1));
              await DatabaseHelper.instance.setToken(widget.user.id!, 0);

              Get.offAll(
                () => LoginPage(),
                transition: Transition.cupertino,
              );
              final snackBar = SnackBar(
                backgroundColor: kuning,
                content: Text(
                  'Logout berhasil',
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 29, 29, 29),
                  ),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              exit = !exit;
              _onClick = !_onClick;
              setState(() {});
            },
          )
            ..show();
        }
      } else {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          animType: AnimType.scale,
          title: "Confirm Logout?",
          desc: "Perubahan tidak akan disimpan!",
          titleTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          descTextStyle: GoogleFonts.quicksand(),
          btnCancelOnPress: () async {},
          btnOkOnPress: () async {
            exit = !exit;
            _onClick = !_onClick;
            setState(() {});
            await Future.delayed(Duration(seconds: 1));
            await DatabaseHelper.instance.setToken(widget.user.id!, 0);

            Get.offAll(
              () => LoginPage(),
              transition: Transition.cupertino,
            );
            final snackBar = SnackBar(
              backgroundColor: kuning,
              content: Text(
                'Logout berhasil',
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 29, 29, 29),
                ),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            exit = !exit;
            _onClick = !_onClick;
            setState(() {});
          },
        )
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final nickName = namaController.text;
        final email = emailController.text;
        final password = passController.text;
        nameEditFocusNode.unfocus();
        emailEditFocusNode.unfocus();
        passEditFocusNode.unfocus();
        print(
            '---> ${pathImages} / ${widget.user.image} | ${nickName} | ${email} | ${password}');
        setState(() {});
        if (pathImages == widget.user.image &&
            nickName == widget.user.fullName &&
            email == widget.user.email &&
            password == widget.user.password) {
          Get.back();
          return true;
        } else {
          if (pathImages == widget.user.image) {
            print('path sama');
            if (nickName == widget.user.fullName) {
              print('nama sama');
              if (email == widget.user.email) {
                print('email sama');
                if (password == widget.user.password) {
                  print('password sama');
                  return true;
                } else {
                  print('password beda');
                  await AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.scale,
                    title: "Save Edit Profile",
                    titleTextStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    descTextStyle: GoogleFonts.quicksand(),
                    btnCancelOnPress: () {
                      Get.offAll(Dashboard(user: widget.user));
                    },
                    btnOkOnPress: () async {
                      editProfile(false);
                    },
                  )
                    ..show();
                  return false;
                }
              } else {
                print('email beda');
                await AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.scale,
                  title: "Save Edit Profile",
                  titleTextStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                  descTextStyle: GoogleFonts.quicksand(),
                  btnCancelOnPress: () {
                    Get.offAll(Dashboard(user: widget.user));
                  },
                  btnOkOnPress: () async {
                    editProfile(false);
                  },
                )
                  ..show();
                return false;
              }
            } else {
              print('nama berubah');
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.scale,
                title: "Save Edit Profile",
                titleTextStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
                descTextStyle: GoogleFonts.quicksand(),
                btnCancelOnPress: () {
                  Get.offAll(Dashboard(user: widget.user));
                },
                btnOkOnPress: () async {
                  editProfile(false);
                },
              )
                ..show();
              return false;
            }
          } else {
            await AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              animType: AnimType.scale,
              title: "Save Edit Profile",
              titleTextStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
              descTextStyle: GoogleFonts.quicksand(),
              btnCancelOnPress: () {
                Get.offAll(Dashboard(user: widget.user));
              },
              btnOkOnPress: () async {
                editProfile(false);
              },
            )
              ..show();
            return false;
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: primary,
            foregroundColor: white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                onPressed: () async {
                  final nickName = namaController.text;
                  final email = emailController.text;
                  final password = passController.text;
                  nameEditFocusNode.unfocus();
                  emailEditFocusNode.unfocus();
                  passEditFocusNode.unfocus();
                  print('---> | <--- ${nickName} | ${email} | ${password}');
                  setState(() {});
                  if (pathImages == widget.user.image &&
                      nickName == widget.user.fullName &&
                      email == widget.user.email &&
                      password == widget.user.password) {
                    Get.back();
                  } else {
                    if (pathImages == widget.user.image) {
                      print('path sama');
                      if (nickName == widget.user.fullName) {
                        print('nama sama');
                        if (email == widget.user.email) {
                          print('email sama');
                          if (password == widget.user.password) {
                            print('password sama');
                            // return true;
                          } else {
                            print('password beda');
                            await AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.scale,
                              title: "Save Edit Profile",
                              titleTextStyle: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                              descTextStyle: GoogleFonts.quicksand(),
                              btnCancelOnPress: () {
                                Get.offAll(Dashboard(user: widget.user));
                              },
                              btnOkOnPress: () async {
                                editProfile(false);
                              },
                            )
                              ..show();
                          }
                        } else {
                          print('email beda');
                          await AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.scale,
                            title: "Save Edit Profile",
                            titleTextStyle: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                            descTextStyle: GoogleFonts.quicksand(),
                            btnCancelOnPress: () {
                              Get.offAll(Dashboard(user: widget.user));
                            },
                            btnOkOnPress: () async {
                              editProfile(false);
                            },
                          )
                            ..show();
                          // return false;
                        }
                      } else {
                        print('nama berubah');
                        await AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.scale,
                          title: "Save Edit Profile",
                          titleTextStyle: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                          descTextStyle: GoogleFonts.quicksand(),
                          btnCancelOnPress: () {
                            Get.offAll(Dashboard(user: widget.user));
                          },
                          btnOkOnPress: () async {
                            editProfile(false);
                          },
                        )
                          ..show();
                        // return false;
                      }
                    } else {
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.scale,
                        title: "Save Edit Profile",
                        titleTextStyle: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                        descTextStyle: GoogleFonts.quicksand(),
                        btnCancelOnPress: () {
                          Get.offAll(Dashboard(user: widget.user));
                        },
                        btnOkOnPress: () async {
                          editProfile(false);
                        },
                      )
                        ..show();
                      // return false;
                    }
                  }

                  setState(() {});
                }),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () => (_onClick) ? tapLogout() : _onClick,
                    icon: exit == false
                        ? Icon(
                            Icons.exit_to_app_rounded,
                          )
                        : Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: white,
                              ),
                            ),
                          )),
              ),
            ],
            title: Text(
              'Profile',
              style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    selectedItem == 'Lihat'
                        ? Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: primary),
                                child: ClipOval(
                                  child: Container(
                                    clipBehavior: Clip.none,
                                    width: 100,
                                    height: 100,
                                    child: isImage != null
                                        ? Image.file(
                                            File(pathImages!),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/profile.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: trans,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: trans,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: trans,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        :
                        // EDIT IMAGE
                        Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  showPicker(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: primary),
                                  child: ClipOval(
                                    child: Container(
                                      clipBehavior: Clip.none,
                                      width: 100,
                                      height: 100,
                                      child: isImage != null
                                          ? Image.file(
                                              File(pathImages!),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/profile.png',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showPicker(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primary,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: white,
                                          size: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Container(
                      height: 400,
                      color: Colors.white,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 20,
                            left: MediaQuery.of(context).size.width / 2 - 150,
                            child: Container(
                              width: 300,
                              // height: 350,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 10)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 25, right: 25),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Ini adalah profile kamu',
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
                                          enabled: selectedItem == 'Lihat'
                                              ? false
                                              : true,
                                          focusNode: nameEditFocusNode,
                                          controller: namaController,
                                          decoration: InputDecoration(
                                              label: Text('Nickname'),
                                              labelStyle: TextStyle(
                                                  color: Colors.black45),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 240, 240, 240)),
                                          onFieldSubmitted: (_) =>
                                              emailEditFocusNode.requestFocus(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          enabled: selectedItem == 'Lihat'
                                              ? false
                                              : true,
                                          controller: emailController,
                                          focusNode: emailEditFocusNode,
                                          decoration: InputDecoration(
                                              label: Text('Email'),
                                              labelStyle: TextStyle(
                                                  color: Colors.black45),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 240, 240, 240)),
                                          onFieldSubmitted: (_) =>
                                              passEditFocusNode.requestFocus(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          enabled: selectedItem == 'Lihat'
                                              ? false
                                              : true,
                                          controller: passController,
                                          focusNode: passEditFocusNode,
                                          obscureText: selectedItem == 'Lihat'
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                              label: Text('Password'),
                                              labelStyle: TextStyle(
                                                  color: Colors.black45),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 240, 240, 240)),
                                          onFieldSubmitted: (_) => (_onClick)
                                              ? editProfile(false)
                                              : _onClick,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      selectedItem == 'Lihat'
                                          ? InkWell(
                                              onTap: () {},
                                              child: Container(
                                                  width: 150,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
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
                                                              width: 1,
                                                            ),
                                                            Text(
                                                              'S A V E',
                                                              style: GoogleFonts.quicksand(
                                                                  color: Colors
                                                                      .transparent,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Icon(
                                                              Icons.save,
                                                              size: 25,
                                                              color: Colors
                                                                  .transparent,
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
                                          : Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () => (_onClick)
                                                          ? confirmDelete()
                                                          : _onClick,
                                                      child: Container(
                                                        width: 100,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    30),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    30),
                                                          ),
                                                        ),
                                                        child: loading2 == false
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 1,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .delete_rounded,
                                                                    size: 25,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 1,
                                                                  ),
                                                                ],
                                                              )
                                                            : Center(
                                                                child: SizedBox(
                                                                  width: 20,
                                                                  height: 20,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    InkWell(
                                                      onTap: () => (_onClick)
                                                          ? editProfile(false)
                                                          : _onClick,
                                                      child: Container(
                                                        width: 100,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    30),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    30),
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
                                                                    width: 1,
                                                                  ),
                                                                  Icon(
                                                                    Icons.save,
                                                                    size: 25,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 1,
                                                                  ),
                                                                ],
                                                              )
                                                            : Center(
                                                                child: SizedBox(
                                                                  width: 20,
                                                                  height: 20,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                    ],
                                  ),

                                  //
                                ],
                              ),
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 35,
                    // ),
                    // Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  onTap: () =>
                                      (_onClick) ? select('Lihat') : _onClick,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            50,
                                    decoration: BoxDecoration(
                                        color: selectedItem == 'Lihat'
                                            ? primary
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: Text(
                                        'Lihat',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            color: selectedItem == 'Lihat'
                                                ? Colors.white
                                                : Colors.black12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () =>
                                      (_onClick) ? select('Edit') : _onClick,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            50,
                                    decoration: BoxDecoration(
                                        color: selectedItem == 'Edit'
                                            ? primary
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: Text(
                                        'Edit',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            color: selectedItem == 'Edit'
                                                ? Colors.white
                                                : Colors.black12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
