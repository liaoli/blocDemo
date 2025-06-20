import 'package:flutter/material.dart';
import '../widgets/user_page.dart';
import '../widgets/settings_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi Bloc Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserPage(),
          Divider(),
          SettingsPage(),
        ],
      ),
    );
  }
}