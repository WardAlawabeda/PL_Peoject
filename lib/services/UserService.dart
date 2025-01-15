// ignore_for_file: missing_required_param

import 'package:pl_project/helper/api.dart'; // Import your custom Api class

class UserService {
  final Api api;
  String? _token; // Store the user's token

  UserService({required this.api});
  // Getter for the token
  String? get token => _token;

  // Sign up user
  Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String location,
    required String phoneNumber,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await Api.post(endPoint: '/register', data: {
        'first_name': firstName,
        "last_name": lastName,
        "location": location,
        "phone_number": phoneNumber,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      _token = response['token']; // Save the token
      return response;
    } catch (e) {
      throw Exception('Sign Up Error: $e');
    }
  }

  // Log in user
  Future<Map<String, dynamic>> logIn(String identifier, String password) async {
    try {
      final response = await Api.post(endPoint: '/login', data: {
        'identifier': identifier,
        'password': password,
      });
      _token = response['token']; // Save the token
      return response;
    } catch (e) {
      throw Exception('Log In Error: $e');
    }
  }

  // Log out user
  Future<void> logOut() async {
    if (_token == null) {
      throw Exception('No user is logged in');
    }

    try {
      await Api.post(
        endPoint: '/logout',
        data: {},
      );

      _token = null; // Clear the token
    } catch (e) {
      throw Exception('Log Out Error: $e');
    }
  }

  Future<Map<String, dynamic>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await Api
          .post(endPoint: '/verify-otp', data: {"email": email, "otp": otp});
          if (response['token'] != null) {
            _token = response["token"];
          }
          return response;
    } catch (e) {
      throw Exception('OTP verification error: $e ');
    }
  }
}
