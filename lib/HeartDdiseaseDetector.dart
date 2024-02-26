import 'dart:typed_data';

import 'package:flutter_tflite/flutter_tflite.dart';

class HeartDiseaseDetector {
  static Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/heart_model.tflite',
      );
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  static Future<int> detectHeartDisease(Map<String, int> data) async {
    try {
      // Convert input data to features
      final List<int> inputData = [
        int.tryParse(data['trestbps'] as String) ?? 0, // Handle invalid input
        int.tryParse(data['cp'] as String) ?? 0,
        int.tryParse(data['chol'] as String) ?? 0,
        int.tryParse(data['fbs'] as String) ?? 0,
        int.tryParse(data['restecg'] as String) ?? 0,
        int.tryParse(data['thalach'] as String) ?? 0,
        int.tryParse(data['exang'] as String) ?? 0,
        int.tryParse(data['oldpeak'] as String) ?? 0,
        int.tryParse(data['slope'] as String) ?? 0,
        int.tryParse(data['ca'] as String) ?? 0,

        // Add other features here
      ];

      print(inputData);

      // Make prediction
      final List? output =
          await Tflite.runModelOnBinary(binary: Uint8List.fromList(inputData));

      // Parse prediction result
      if (output != null && output.isNotEmpty) {
        final int prediction = output[0] as int;
        return prediction;
      } else {
        print('Prediction output is null or empty');
        return -1;
      }
    } catch (e) {
      print('Failed to make prediction: $e');
      return -1;
    }
  }
}
