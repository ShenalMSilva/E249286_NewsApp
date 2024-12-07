import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final ValueNotifier<bool> isDarkModeNotifier;

  SettingsPage({required this.isDarkModeNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return SwitchListTile(
                  title: Text('Dark Mode'),
                  value: isDarkMode,
                  onChanged: (value) {
                    isDarkModeNotifier.value = value; // Update the notifier
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Text('App Version: 1.0', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}