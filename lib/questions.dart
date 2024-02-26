import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:googl/HeartDdiseaseDetector.dart';

import 'package:unicons/unicons.dart';

class questions extends StatefulWidget {
  const questions({super.key});

  @override
  State<questions> createState() => _questionsState();
}

class _questionsState extends State<questions> {
  @override
  Widget build(BuildContext context) {
    var arrHintText = [
      'Resting blood pressure (in mm Hg on admission to the hospital)',
      'Chest pain type',
      'Serum cholestoral in mg/dl',
      'Fasting blood sugar &gt; 120 mg/dl',
      'Esting electrocardiographic results',
      'Maximum heart rate achieved',
      'Exercise induced angina',
      'ST depression induced by exercise relative to rest',
      'The slope of the peak exercise ST segment',
      'Number of major vessels (0-3) colored by flourosopy',
    ];
    List<TextEditingController> controller =
        List.generate(arrHintText.length, (i) => TextEditingController());
    String predictionResult = '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF252c4a),
            pinned: true,
            expandedHeight: (MediaQuery.of(context).size.height) * 0.35,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                height: (MediaQuery.of(context).size.height) * 0.05,
                // width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                width: double.infinity,
                // padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller[index],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(
                        color: const Color(0xFF252c4a),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    hintText: arrHintText[index],
                    prefixIcon: const Icon(
                      UniconsLine.pen,
                      color: Colors.grey,
                    ),
                    prefixText: ' ',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              );
            },
            itemCount: arrHintText.length,
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  height: (MediaQuery.of(context).size.height) * 0.08,
                  width: (MediaQuery.of(context).size.width) * 0.59,
                  child: ElevatedButton(
                    onPressed: () async {
                      final inputData = await {
                        'trestbps': int.tryParse(controller[0].text) ?? 0,
                        'cp': int.tryParse(controller[1].text) ?? 0,
                        'chol': int.tryParse(controller[2].text) ?? 0,
                        'fbs': int.tryParse(controller[3].text) ?? 0,
                        'restecg': int.tryParse(controller[4].text) ?? 0,
                        'thalach': int.tryParse(controller[5].text) ?? 0,
                        'exang': int.tryParse(controller[6].text) ?? 0,
                        'oldpeak': int.tryParse(controller[7].text) ?? 0,
                        'slope': int.tryParse(controller[8].text) ?? 0,
                        'ca': int.tryParse(controller[9].text) ?? 0,
                      };
                      final prediction =
                          await HeartDiseaseDetector.detectHeartDisease(
                              inputData);
                      setState(() {
                        predictionResult = prediction == 0
                            ? "No Heart Disease"
                            : "Heart Diesease Detected";
                      });

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Prediction Result'),
                            content: Text(predictionResult),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      // Handle prediction result as needed
                    },
                    child: Text(
                      'Check',
                      style: TextStyle(fontSize: 16),
                    ),
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
          ),
        ],
      ),
    );
  }
}
