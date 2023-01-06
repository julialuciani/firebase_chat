import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
