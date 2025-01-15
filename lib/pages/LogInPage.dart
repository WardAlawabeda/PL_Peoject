import 'package:flutter/material.dart';
import 'package:pl_project/helper/api.dart';
import 'package:pl_project/pages/OtpPage.dart';
import 'package:pl_project/pages/SignInPage.dart';
import 'package:pl_project/widgets/CustomButton.dart';
import 'package:pl_project/widgets/CustomEffect.dart';
import 'package:pl_project/services/UserService.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LoginState();
}

class _LoginState extends State<LogInPage> {
  final TextEditingController userName = TextEditingController();
  final GlobalKey<FormState> userNameKey = GlobalKey();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> passwordKey = GlobalKey();

  bool showPass = true;
  final UserService userService = UserService(api : Api()); // Initialize UserService

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  bool isValidPhoneNumber(String phoneNumber) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp syrianPhoneRegExp = RegExp(pattern);

    return syrianPhoneRegExp.hasMatch(phoneNumber);
  }

  bool emailValidating(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp emailRegExp = RegExp(pattern);
    return emailRegExp.hasMatch(email);
  }

  void handleLogin() async {
    if (userNameKey.currentState!.validate() && passwordKey.currentState!.validate()) {
      try {
        // Prepare login data
        String username = userName.text.trim();
        String pwd = password.text.trim();

        // Call the login function from UserService
        final response = await userService.logIn(username, pwd);

        if (response['status'] == 'success') {
          // Navigate to OTP page on successful login
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OtpPage(email:userName.text)),
          );
        } else {
          // Handle error from API
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login Failed'),
              content: Text(response['message'] ?? 'Unknown error occurred.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                )
              ],
            ),
          );
        }
      } catch (e) {
        // Handle exception
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              )
            ],
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
            const SizedBox(
              height: 120,
            ),
            const Column(
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      fontFamily: "PTSerif-Bold"),
                ),
                Text("Enter your credential for login"),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
            Form(
              key: userNameKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "can't be empty";
                  }
                  if (emailValidating(value) || isValidPhoneNumber(value)) {
                    return null;
                  } else {
                    return "enter your email or phone number";
                  }
                },
                controller: userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.pink[50],
                  hintText: "Email Or Phone number",
                  hintStyle: const TextStyle(
                      fontFamily: "PTSerif-Regular",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: passwordKey,
              child: TextFormField(
                obscureText: showPass,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "cant be empty";
                  }
                  if (value.length < 8) {
                    return "password should be at least 8 characters";
                  }
                  return null;
                },
                controller: password,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffixIcon: (password.text.isEmpty)
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                        ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.pink[50],
                  hintText: "Password",
                  hintStyle: const TextStyle(
                      fontFamily: "PTSerif-Regular",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              buttonname: "Login Now",
              ontap: handleLogin, // Call the handleLogin method
            ),
            const SizedBox(
              height: 250,
            ),
            CustomEffect(
              blackHint: "Dont Have An Account ? ",
              orangeHint: 'Sign Up',
              navigation: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const SignInPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
