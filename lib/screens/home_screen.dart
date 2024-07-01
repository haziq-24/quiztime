// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/result_box.dart';
import '../constants.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../models/db_connect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBConnect();
  late Future<List<Question>> questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    questions = getData();
    super.initState();
  }

  int currentIndex = 0;
  int score = 0;
  bool isOptionSelected = false;
  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (currentIndex == questionLength - 1) {
      showDialog(
        context: context,
        builder: (ctx) => ResultBox(
          score: score,
          totalQuestions: questionLength,
          onPressed: resetQuiz,
        ),
      );
    } else {
      if (isOptionSelected) {
        setState(() {
          currentIndex++;
          isOptionSelected = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select an answer to continue'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswer(bool isCorrect) {
    if (isAlreadySelected) return;
    setState(() {
      if (isCorrect) {
        score++;
      }
      isOptionSelected = true;
      isAlreadySelected = true;
    });
  }

  void resetQuiz() {
    Navigator.of(context).pop();
    setState(() {
      score = 0;
      currentIndex = 0;
      isOptionSelected = false;
      isAlreadySelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: questions,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('Quiz App'),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    QuestionWidget(
                      question: extractedData[currentIndex].title,
                      indexAction: currentIndex,
                      totalQuestions: extractedData.length,
                    ),
                    const Divider(color: neutral),
                    const SizedBox(height: 25.0),
                    ...extractedData[currentIndex].options.entries.map((entry) {
                      return GestureDetector(
                        onTap: () => checkAnswer(entry.value),
                        child: OptionCard(
                          option: entry.key,
                          color: isOptionSelected
                              ? entry.value
                                  ? correct
                                  : incorrect
                              : neutral,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text(
                  'Please wait while Questions are loading...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}
