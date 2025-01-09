import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pl_project/pages/OtpPage.dart';
import 'package:pl_project/widgets/CustomButton.dart';
import 'package:pl_project/widgets/CustomEffect.dart';
import 'package:pl_project/widgets/CustomTextField.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  void takePhoto(ImageSource source) async {
    XFile? imagePicked = await picker.pickImage(source: source);
    setState(() {
      image = imagePicked;
    });
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  bool Show = true;
  bool Showw = true;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();

  TextEditingController location = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();
  GlobalKey<FormState> firstnamek = GlobalKey();
  GlobalKey<FormState> lastnamek = GlobalKey();

  GlobalKey<FormState> locationk = GlobalKey();
  GlobalKey<FormState> emailk = GlobalKey();
  GlobalKey<FormState> phonek = GlobalKey();
  GlobalKey<FormState> passwordk = GlobalKey();
  GlobalKey<FormState> conpasswordk = GlobalKey();

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    location.dispose();
    email.dispose();
    password.dispose();
    conpassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          padding: const EdgeInsets.all(30),
          child: ListView(children: [
            Column(
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      fontFamily: "PTSerif-Bold"),
                ),
                const Text("Create Your Account"),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: (image == null)
                          ? const AssetImage("images/download.jpg")
                          : FileImage(File(image!.path)),
                    ),
                    Positioned(
                      bottom: -7,
                      right: 60,
                      child: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!
                                .showBottomSheet((context) => Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                        ),
                                      ),
                                      height: 150,
                                      width: 1000,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Pick Your Profile Image",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily:
                                                    "fonts/PTSerif-Bold"),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MaterialButton(
                                                onPressed: () {
                                                  takePhoto(ImageSource.camera);
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.camera),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "fonts/PTSerif-Regular"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  takePhoto(
                                                      ImageSource.gallery);
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.photo),
                                                    SizedBox(width: 5),
                                                    Text("Gallery",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "fonts/PTSerif-Regular")),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                          },
                          icon: const Icon(Icons.add_a_photo)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Customformfield(
              show: false,
              hint: "First Name",
              iconname: const Icon(Icons.person_outline_outlined),
              valid: (value) {
                if (value == "") {
                  return "can't be empty";
                }
                return null;
              },
              Textformfield: firstname,
              globalKey: firstnamek,
            ),
            const SizedBox(
              height: 10,
            ),
            Customformfield(
              show: false,
              hint: "Last Name",
              iconname: const Icon(Icons.person_outline_outlined),
              valid: (value) {
                if (value == "") {
                  return "can't be empty";
                }
                return null;
              },
              Textformfield: lastname,
              globalKey: lastnamek,
            ),
            const SizedBox(
              height: 10,
            ),
            Customformfield(
              show: false,
              hint: "Loacation",
              iconname: const Icon(Icons.location_history_outlined),
              valid: (value) {
                if (value == "") {
                  return "can't be empty";
                }
                return null;
              },
              Textformfield: location,
              globalKey: locationk,
            ),
            const SizedBox(
              height: 10,
            ),
            Customformfield(
              show: false,
              hint: "Email",
              iconname: const Icon(Icons.email_outlined),
              valid: (value) {
                String pattern =
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$';
                final RegExp emailRegExp = RegExp(pattern);
                if (value == "") {
                  return "can't be empty";
                }
                if (!emailRegExp.hasMatch(value)) {
                  return "enter valid email";
                }
                return null;
              },
              Textformfield: email,
              globalKey: emailk,
            ),
            const SizedBox(
              height: 10,
            ),
            Customformfield(
              show: false,
              hint: "Phone",
              iconname: const Icon(Icons.phone),
              valid: (value) {
                String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                final RegExp syrianPhoneRegExp = RegExp(pattern);
                if (value == "") {
                  return "can't be empty";
                }
                if (!syrianPhoneRegExp.hasMatch(value)) {
                  return "write valid phone number";
                }

                return null;
              },
              Textformfield: phone,
              globalKey: phonek,
            ),
            const SizedBox(
              height: 10,
            ),
            Customformfield(
                hint: "Password",
                iconname: const Icon(Icons.lock_outline),
                suff: InkWell(
                  onTap: () {
                    (Show == true) ? Show = false : Show = true;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.remove_red_eye,
                  ),
                ),
                show: Show,
                valid: (ValueKey) {
                  if (password.text == "") {
                    return "can't be empty";
                  }
                  if (password.text.length < 8) {
                    return "password should be at less 8";
                  }
                },
                Textformfield: password,
                globalKey: passwordk),
            const SizedBox(
              height: 10,
            ),
            Customformfield(
                hint: "Conform Password",
                iconname: const Icon(Icons.lock_outline),
                suff: InkWell(
                  onTap: () {
                    (Showw == true) ? Showw = false : Showw = true;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.remove_red_eye,
                  ),
                ),
                show: Showw,
                valid: (value) {
                  if (conpassword.text != password.text) {
                    return "conform to both passwoed";
                  }
                },
                Textformfield: conpassword,
                globalKey: conpasswordk),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              buttonname: "Sign Up",
              ontap: () {
                if (firstnamek.currentState!.validate() &&
                    lastnamek.currentState!.validate() &&
                    locationk.currentState!.validate() &&
                    emailk.currentState!.validate() &&
                    phonek.currentState!.validate() &&
                    passwordk.currentState!.validate() &&
                    conpasswordk.currentState!.validate()) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const OtpPage()));
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomEffect(
              blackHint: "Already Have An Account ? ",
              orangeHint: ' Login',
              navigation: () {
                Navigator.of(context).pop();
              },
            )
          ]),
        ));
  }
}