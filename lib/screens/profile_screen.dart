import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool isWorker;
  final ValueChanged<bool> onModeChanged;

  const ProfileScreen({
    super.key,
    required this.isWorker,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 36,
                  child: Icon(Icons.person, size: 36),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Abdullah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'abdullah@example.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('User Details'),
                subtitle: const Text('Member since 2024\nVerified'),
              ),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              value: isWorker,
              onChanged: onModeChanged,
              title: const Text('Worker mode'),
              subtitle: const Text('Switch to worker to offer services'),
              secondary: const Icon(Icons.swap_horiz),
            ),

            const SizedBox(height: 12),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
