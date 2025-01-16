import 'package:flutter/material.dart';
import 'package:pl_project/pages/EditPage.dart';
import 'package:pl_project/services/ProfileService.dart';

class ProfilePage extends StatefulWidget {
  final ProfileService profileService; // Inject the ProfileService

  const ProfilePage({super.key, required this.profileService});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userInfoFuture;
  final bool _showAvatars = false;

  String? _selectedAvatar; // Store the currently selected avatar
  String? _confirmedAvatar; // Store the confirmed avatar
  final List<String> _avatarPaths = [
    'assets/images/avatars/avatar1.png',
    'assets/images/avatars/avatar2.png',
    'assets/images/avatars/avatar3.png',
    'assets/images/avatars/avatar4.png',
    'assets/images/avatars/avatar5.png',
    'assets/images/avatars/avatar6.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _userInfoFuture = widget.profileService.getUserInfo();
  }

  Future<void> _updateAvatar(String avatarPath) async {
    try {
      final avatarId = _avatarPaths.indexOf(avatarPath) + 1; // Use index as ID
      await widget.profileService.updateProfilePhoto(avatarId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avatar updated successfully!')),
      );

      // Refresh user info to update the avatar
      setState(() {
        _userInfoFuture = widget.profileService.getUserInfo();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating avatar: $e')),
      );
    }
  }

  void _editAvatar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Avatar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _avatarPaths.length,
                  itemBuilder: (context, index) {
                    final avatar = _avatarPaths[index];
                    final isSelected = _selectedAvatar == avatar;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // If the same avatar is clicked twice, confirm it
                          if (_selectedAvatar == avatar) {
                            _confirmedAvatar = avatar;

                            // Call the service to update the avatar
                            _updateAvatar(avatar);
                            Navigator.pop(context); // Close the modal
                          } else {
                            _selectedAvatar = avatar;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(avatar),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editDetail(String label, String currentValue,
      Future<String> Function(String) updateFunction) {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $label'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await updateFunction(controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$label updated successfully!')),
                  );
                  setState(() {
                    _userInfoFuture = widget.profileService.getUserInfo();
                  });
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating $label: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              // Logout action
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Handle logout here
                      },
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data available.'));
          }

          final userInfo = snapshot.data!;
          return Column(
            children: [
              _buildProfileHeader(userInfo),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  children: [
                    _buildDetailTile("Firstname", userInfo['first_name'],
                        widget.profileService.updateFirstName),
                    _buildDetailTile("Lastname", userInfo['last_name'],
                        widget.profileService.updateLastName),
                    _buildDetailTile("Email", userInfo['email'],
                        widget.profileService.updateEmail),
                    _buildDetailTile("Phone", userInfo['phone_number'],
                        widget.profileService.updatePhoneNumber),
                    _buildDetailTile("Location", userInfo['location'],
                        widget.profileService.updateLocation),
                    _buildPasswordTile(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> userInfo) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      height: 250,
      child: Column(
        children: [
          InkWell(
            onTap: _editAvatar, // Open the avatar selection
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _confirmedAvatar != null
                  ? AssetImage(_confirmedAvatar!)
                  : NetworkImage(userInfo['profile_photo_url'])
                      as ImageProvider,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${userInfo['first_name']} ${userInfo['last_name']}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userInfo['email'],
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailTile(String label, String value,
      Future<String> Function(String) updateFunction) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.pink[50]),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () => _editDetail(label, value, updateFunction),
          icon: const Icon(Icons.edit, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildPasswordTile() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "********",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPage(
                  profileService : widget.profileService,
                ),
              ),
            );
          },
          icon: const Icon(Icons.edit, color: Colors.blue),
        ),
      ],
    );
  }
}
