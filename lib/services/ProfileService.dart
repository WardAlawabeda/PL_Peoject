import 'package:pl_project/helper/api.dart';

class ProfileService {
  final Api api;
  final String? token; // The user's token for authentication

  ProfileService({required this.api, required this.token});

  // Get the information of the user
  Future<Map<String, dynamic>> getUserInfo() async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.get(
        endPoint: '/api/profile',
        token: token,
      );
      return response['data'];
    } catch (e) {
      throw Exception('Error fetching user information: $e');
    }
  }

  // Get the list of profile photos
  Future<List<dynamic>> getProfilePhotos() async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.get(
        endPoint: '/api/profile/photos',
        token: token,
      );
      return response['photos'];
    } catch (e) {
      throw Exception('Error fetching profile photos: $e');
    }
  }

  // Update the profile photo
  Future<Map<String, dynamic>> updateProfilePhoto(int photoId) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/photo',
        token: token,
        data: {
          'photo_id': photoId,
        },
      );
      return response['data'];
    } catch (e) {
      throw Exception('Error updating profile photo: $e');
    }
  }

  // Update the first name
  Future<String> updateFirstName(String firstName) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/first-name',
        token: token,
        data: {
          'first_name': firstName,
        },
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error updating first name: $e');
    }
  }

  // Update the last name
  Future<String> updateLastName(String lastName) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/last-name',
        token: token,
        data: {
          'last_name': lastName,
        },
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error updating last name: $e');
    }
  }

  // Update the location
  Future<String> updateLocation(String location) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/location',
        token: token,
        data: {
          'location': location,
        },
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error updating location: $e');
    }
  }

  // Update the email
  Future<String> updateEmail(String email) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/email',
        token: token,
        data: {
          'email': email,
        },
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error updating email: $e');
    }
  }

  // Update the password
  Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/password',
        token: token,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error updating password: $e');
    }
  }

  // Update the phone number
  Future<String> updatePhoneNumber(String phoneNumber) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/profile/phone-number',
        token: token,
        data: {
          'phone_number': phoneNumber,
        },
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error updating phone number: $e');
    }
  }
}
