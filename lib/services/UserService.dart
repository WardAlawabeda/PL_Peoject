import 'package:pl_project/helper/api.dart'; // Import your custom Api class
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class UserService {
  final Api api;
  String? _token; // Store the user's token locally

  UserService({required this.api});

  // Getter for the token
  String? get token => _token;

  // Save the token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token); // Save token with the key 'user_token'
  }

  // Retrieve the token from SharedPreferences
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('user_token'); // Get the token using the key 'user_token'
  }

  // Remove the token from SharedPreferences
  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token'); // Remove the token from storage
  }

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

      if (response['token'] != null) {
        _token = response['token']; // Save the token
        await _saveToken(_token!); // Persist the token
      }

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

      if (response['token'] != null) {
        _token = response['token']; // Save the token
        await _saveToken(_token!); // Persist the token
      }

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
      await _removeToken(); // Remove the token from storage
    } catch (e) {
      throw Exception('Log Out Error: $e');
    }
  }

  // Verify OTP
  Future<Map<String, dynamic>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await Api.post(endPoint: '/verify-otp', data: {"email": email, "otp": otp});
      if (response['token'] != null) {
        _token = response["token"];
        await _saveToken(_token!); // Persist the token
      }
      return response;
    } catch (e) {
      throw Exception('OTP verification error: $e ');
    }
  }

  // Load the token when the app starts
  Future<void> loadToken() async {
    await _loadToken(); // Load the token from SharedPreferences
  }
}
