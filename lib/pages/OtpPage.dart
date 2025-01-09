import 'package:flutter/material.dart';
import 'package:pl_project/widgets/CustomButton.dart';
import 'package:pl_project/pages/HomePage.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> t1k = GlobalKey();

  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListView(
          children: [
            const Center(
              child: Text(
                "Validation",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: "PTSerif-Bold"),
              ),
            ),
            const Icon(
              Icons.mark_email_read_outlined,
              color: Colors.deepOrange,
              size: 50,
            ),
            const Text(
              "Check Your Email And Enter The Code",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: t1k,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 54,
                      width: 58,
                      child: TextFormField(
                        validator: (ValueKey) {
                          if (ValueKey!.isEmpty) return "";
                          return null;
                        },
                        onSaved: (pin1) {},
                        onChanged: (val) {
                          if (val.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), counterText: ""),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      width: 58,
                      child: TextFormField(
                        validator: (ValueKey) {
                          if (ValueKey!.isEmpty) return "";
                          return null;
                        },
                        onSaved: (pin1) {},
                        onChanged: (val) {
                          if (val.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (val.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), counterText: ""),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      width: 58,
                      child: TextFormField(
                        validator: (ValueKey) {
                          if (ValueKey!.isEmpty) return "";
                          return null;
                        },
                        onSaved: (pin1) {},
                        onChanged: (val) {
                          if (val.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (val.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), counterText: ""),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      width: 58,
                      child: TextFormField(
                        validator: (ValueKey) {
                          if (ValueKey!.isEmpty) return "";
                          return null;
                        },
                        onSaved: (pin1) {},
                        onChanged: (val) {
                          if (val.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (val.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), counterText: ""),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      width: 58,
                      child: TextFormField(
                        validator: (ValueKey) {
                          if (ValueKey!.isEmpty) return "";
                          return null;
                        },
                        onSaved: (pin1) {},
                        onChanged: (val) {
                          if (val.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (val.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), counterText: ""),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      width: 58,
                      child: TextFormField(
                        validator: (ValueKey) {
                          if (ValueKey!.isEmpty) return "";
                          return null;
                        },
                        onSaved: (pin1) {},
                        onChanged: (val) {
                          if (val.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (val.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), counterText: ""),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLength: 1,
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              buttonname: "Valid",
              ontap: () {
                (t1k.currentState!.validate())
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()))
                    : null;
              },
            ),
          ],
        ),
      ),
    );
  }
}