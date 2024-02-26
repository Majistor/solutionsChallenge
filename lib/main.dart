import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:googl/HeartDdiseaseDetector.dart';

import 'package:googl/questions.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      tools: [...DevicePreview.defaultTools],
      builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HeartDiseaseDetector.loadModel();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final Color mainColor = const Color(0xFF252c4a);
  final Color secondColor = const Color(0xFF117eeb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                  radius: (MediaQuery.of(context).size.height) * 0.15,
                  backgroundImage: AssetImage(
                      "assets/images/Firefly generate a cartoonish image relatedd to heart for a heart disease detector app 93193.jpg")),
            ),
            Container(
              height: (MediaQuery.of(context).size.height) * 0.55,
              width: (MediaQuery.of(context).size.width) * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.09,
                    width: (MediaQuery.of(context).size.width) * 0.59,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const questions()));
                      },
                      child: Text("Next"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
