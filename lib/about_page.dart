import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  final bool isdark;
  const AboutPage({required this.isdark, super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.isdark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: Column(
          children: [
            Text(
              '-This is a simple offline English dictionary Flutter application\n-Created by Habtemariam Melsie',
              style: TextStyle(
                fontSize: 20,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
