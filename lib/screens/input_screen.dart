import 'package:flutter/material.dart';
import 'package:my_bmi_calc/localization/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_styles.dart';
import '../model/gender.dart';
import '../model/result.dart';
import '../routes/routes.dart';
import '../services/calculator.dart';
import '../utils/widget_utils.dart';
import '../widgets/bottom_button.dart';
import '../widgets/icon_content.dart';
import '../widgets/reusable_card.dart';
import '../widgets/round_icon_button.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage>
    with SingleTickerProviderStateMixin {
  Gender selectedGender = Gender.other;
  int height = 160;
  int weight = 60;
  int age = 20;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: -1,
      upperBound: 0,
    );

    controller.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localize('title')),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteGenerator.historyPage,
            ).then((value) {
              controller.reset();
              controller.forward();
            });
          },
          icon: const Icon(Icons.history),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  selectedGender = Gender.other;
                  height = 180;
                  weight = 60;
                  age = 20;
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(controller.value * 200, 0),
                      child: child,
                    );
                  },
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    cardChild: IconContent(
                      icon: Icons.male,
                      label: context.localize('male'),
                      color: selectedGender == Gender.male
                          ? Colors.blueAccent
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(controller.value * -200, 0),
                      child: child,
                    );
                  },
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    cardChild: IconContent(
                      icon: Icons.female,
                      label: context.localize('female'),
                      color: selectedGender == Gender.female
                          ? Colors.orange
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(controller.value * -400, 0),
                  child: child,
                );
              },
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      context.localize('height'),
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        const Text(
                          'cm',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: const Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: const Color(0xFFEB1555),
                        overlayColor: const Color(0x29EB1555),
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 15.0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(controller.value * 200, 0),
                        child: child,
                      );
                    },
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            context.localize('weight'),
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    setState(() {
                                      weight--;
                                    });
                                  }),
                              const SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(controller.value * -200, 0),
                        child: child,
                      );
                    },
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            context.localize('male'),
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(
                                    () {
                                      age--;
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: context.localize('calculate'),
            onTap: () async {
              if (selectedGender == Gender.other) {
                showSnackBar(context, "Please select your gender!!!");
              } else {
                Calculator calc = Calculator(
                  height: height,
                  weight: weight,
                );

                /// Move to next screen and reset the animation
                Navigator.pushNamed(context, RouteGenerator.resultPage,
                        arguments: BMIResult(
                            resultBMIScore: await calc.calculateBMI(),
                            resultText: await calc.getResult(),
                            resultInterpretation:
                                await calc.getInterpretation(),
                            resultColor: await calc.getStatusColor()))
                    .then((value) {
                  controller.reset();
                  controller.forward();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
