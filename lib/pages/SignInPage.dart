import 'package:flutter/material.dart';
import 'package:pl_project/helper/api.dart';
import 'package:pl_project/services/UserService.dart';
import 'package:pl_project/pages/OtpPage.dart';
import 'package:pl_project/widgets/CustomButton.dart';
import 'package:pl_project/widgets/CustomEffect.dart';
import 'package:pl_project/widgets/CustomTextField.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final List<String> avatars = [
    "assets/avatars/avatar1.jpg",
    "assets/avatars/avatar2.jpg",
    "assets/avatars/avatar3.jpg",
    "assets/avatars/avatar4.jpg",
    "assets/avatars/avatar5.jpg",
    "assets/avatars/avatar6.jpg",
  ];

  String? selectedAvatar;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> firstnameKey = GlobalKey<FormState>();
  GlobalKey<FormState> lastnameKey = GlobalKey<FormState>();
  GlobalKey<FormState> locationKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  GlobalKey<FormState> conpasswordKey = GlobalKey<FormState>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    location.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    conpassword.dispose();
    super.dispose();
  }

  String? validateNonEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName can't be empty";
    }
    return null;
  }

  String? validateEmail(String? value) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$';
    final regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      if (selectedAvatar == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select an avatar."),
          ),
        );
        return;
      }

      final userService = UserService(api:Api());
      final response = await userService.signUp(
        firstName: firstname.text,
        lastName: lastname.text,
        location: location.text,
        email: email.text,
        phoneNumber: phone.text,
        password: password.text,
        passwordConfirmation: conpassword.text,
        // avatar: selectedAvatar!,
      );

      if (response["message"] == "User created successfully. Please verify your email.") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OtpPage(email: email.text,),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"] ?? "Sign up failed."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    fontFamily: "PTSerif-Bold",
                  ),
                ),
                const Text("Create Your Account"),
                const SizedBox(height: 30),
                // Avatar selection
                const Text(
                  "Choose an Avatar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: avatars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = avatars[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedAvatar == avatars[index]
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(avatars[index]),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Customformfield(
                    globalKey: firstnameKey,
                    show: false,
                    hint: "First Name",
                    iconname: const Icon(Icons.person_outline_outlined),
                    valid: (value) => validateNonEmpty(value, "First Name"),
                    Textformfield: firstname,
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    globalKey: lastnameKey,
                    show: false,
                    hint: "Last Name",
                    iconname: const Icon(Icons.person_outline_outlined),
                    valid: (value) => validateNonEmpty(value, "Last Name"),
                    Textformfield: lastname,
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    globalKey: locationKey,
                    show: false,
                    hint: "Location",
                    iconname: const Icon(Icons.location_history_outlined),
                    valid: (value) => validateNonEmpty(value, "Location"),
                    Textformfield: location,
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    globalKey: emailKey,
                    show: false,
                    hint: "Email",
                    iconname: const Icon(Icons.email_outlined),
                    valid: validateEmail,
                    Textformfield: email,
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    globalKey: phoneKey,
                    show: false,
                    hint: "Phone",
                    iconname: const Icon(Icons.phone),
                    valid: (value) => validateNonEmpty(value, "Phone"),
                    Textformfield: phone,
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    globalKey: passwordKey,
                    hint: "Password",
                    iconname: const Icon(Icons.lock_outline),
                    show: true,
                    valid: validatePassword,
                    Textformfield: password,
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    globalKey: conpasswordKey,
                    hint: "Confirm Password",
                    iconname: const Icon(Icons.lock_outline),
                    show: true,
                    valid: (value) {
                      if (value != password.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    Textformfield: conpassword,
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    buttonname: "Sign Up",
                    ontap: signUp,
                  ),
                  const SizedBox(height: 20),
                  CustomEffect(
                    blackHint: "Already Have An Account ? ",
                    orangeHint: ' Login',
                    navigation: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
