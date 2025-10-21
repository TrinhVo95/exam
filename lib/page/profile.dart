import 'package:exam/utils/routes.dart';
import 'package:exam/widgets/setting_item.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Mia Mia';
  String email = 'mialuna@email.com';

  Future<void> _showEditDialog(BuildContext context) async {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);

    String? nameError;
    String? emailError;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      errorText: nameError,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: emailError,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // validate
                    setStateDialog(() {
                      nameError = nameController.text.isEmpty
                          ? 'Name cannot be empty'
                          : null;
                      emailError = !emailController.text.contains('@')
                          ? 'Invalid email'
                          : null;
                    });

                    if (nameError == null && emailError == null) {
                      setState(() {
                        name = nameController.text;
                        email = emailController.text;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Profile',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.homePage);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.orange,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ClipOval(
                  child: Image.asset(
                    'assets/image/avatar.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF969696),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showEditDialog(context),
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SettingItem(
                  title: 'Notifications Center',
                  icon: Icons.notification_add,
                  onTap: () {},
                ),
                SettingItem(
                  title: 'Change Password',
                  icon: Icons.key_sharp,
                  onTap: () {},
                ),
                SettingItem(
                  title: 'Language',
                  icon: Icons.language,
                  onTap: () {},
                ),
                SettingItem(
                  title: 'FAQs',
                  icon: Icons.help_center,
                  onTap: () {},
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.orange),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: const [
                        Icon(Icons.logout, color: Colors.orange),
                        Text('Logout', style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
