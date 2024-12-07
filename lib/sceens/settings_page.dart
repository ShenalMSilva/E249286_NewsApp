import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings',
          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal)),
        backgroundColor: Colors.teal,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  if (_isDarkMode) {
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).copyWith(brightness: Brightness.light)
                        : Theme.of(context).copyWith(brightness: Brightness.dark);
                  }
                });
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