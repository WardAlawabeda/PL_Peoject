// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:pl_project/widgets/CustomButton.dart'; // Assuming you have this custom widget
import 'package:pl_project/pages/HomePage.dart'; // Import your HomePage
import 'package:pl_project/helper/api.dart'; // Import your custom Api class
import 'package:pl_project/services/UserService.dart'; // Import UserService class

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> t1k = GlobalKey();
  List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  // UserService instance for OTP verification
  final UserService userService = UserService(api: Api());

  @override
  void initState() {
    super.initState();
  }

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
            const SizedBox(height: 30),
            Form(
              key: t1k,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    height: 54,
                    width: 58,
                    child: TextFormField(
                      controller: otpControllers[index],
                      validator: (ValueKey) {
                        if (ValueKey!.isEmpty) return "";
                        return null;
                      },
                      onSaved: (pin1) {},
                      onChanged: (val) {
                        if (val.length == 1) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        }
                        if (val.isEmpty) {
                          if (index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
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
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonname: "Validate",
              ontap: () async {
                if (t1k.currentState!.validate()) {
                  // Collect OTP from the text controllers
                  String otp =
                      otpControllers.map((controller) => controller.text).join();

                  try {
                    // Verify the OTP with the backend
                    var response = await userService.verifyOTP(
                      email: widget.email,
                      otp: otp,
                    );

                    // Check if OTP is verified and handle the response
                    if (response['token'] != null) {
                      // Navigate to the HomePage if OTP is valid
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    } else {
                      // Show error message if OTP is incorrect
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid OTP")),
                      );
                    }
                  } catch (e) {
                    // Handle OTP verification error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP verification failed")),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
