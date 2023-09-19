import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_styles.dart';
import '../model/result.dart';
import '../widgets/bottom_button.dart';
import '../widgets/reusable_card.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key, required this.bmiResult}) : super(key: key);

  final BMIResult bmiResult;

  void onSavePressed(String bmi, String status, int statusColor) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> saveList = prefs.getStringList('saveList') ?? [];
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(now);

      saveList.add(
          '{"bmi":"$bmi","status":"$status","statusColor":"$statusColor","formattedDate":"$formattedDate"}');

      await prefs.setStringList('saveList', saveList);
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              onSavePressed(bmiResult.resultBMIScore, bmiResult.resultText,
                  bmiResult.resultColor.value);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    bmiResult.resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult.resultBMIScore,
                    style: kBMITextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      bmiResult.resultInterpretation,
                      textAlign: TextAlign.center,
                      style: kBodyTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
