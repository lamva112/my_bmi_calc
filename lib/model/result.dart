import 'package:flutter/material.dart';

class BMIResult {
  final String resultText;
  final String resultBMIScore;
  final String resultInterpretation;
  final Color resultColor;

  BMIResult({
    this.resultText = "",
    this.resultBMIScore = "",
    this.resultInterpretation = "",
    this.resultColor = Colors.transparent
  });
}
