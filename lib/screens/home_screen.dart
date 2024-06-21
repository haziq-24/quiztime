import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/result_box.dart';
import '../constants.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> questions = [
    Question(
        id: '10',
        title: 'Whats is Capital City for Pahang ?',
        options: {'Pulau Pinang': false, 'Perlis': false, 'Kuantan': true, 'Bentong': false}),
    Question(
        id: '11',
        title: ' Is durian a local fruit for the state of Pahang ?',
        options: {'No': false, 'Yes': true, 'I think so': false, 'I dont know': false}),
         Question(
        id: '12',
        title: ' What is 2 + 200 ?',
        options: {'2001': false, '2002': true, '198': false, '2003': false}),
         Question(
        id: '13',
        title: ' What is 2 + 2 ?',
        options: {'8': false, '10': false, '4': true, '2': false}),
         Question(
        id: '14',
        title: ' Whats is the friends of Jerry ?',
        options: {'Tom': true, 'Kasim': false, 'Lily': false, 'Black': false}),
         Question(
        id: '15',
        title: ' Whats is brother of Upin ?',
        options: {'Uncle Muthu': false, 'Kak Ros': false, 'Opah': false, 'Ipin': true}),
         Question(
        id: '16',
        title: ' Whats is 200 + 400 ?',
        options: {'900': false, '10000': false, '500': false, '600': true}),
         Question(
        id: '17',
        title: ' What is 2 + 10 ?',
        options: {'14': false, '10': false, '12': true, '13': false}),
         Question(
        id: '18',
        title: ' Ali had 2 apples, then he gave 1 apple to muhammad so how many apples does Ali have now ?',
        options: {'8': false, '10': false, '1': true, '2': false}),
         Question(
        id: '19',
        title: ' What is the shape of an ice cream cone ?',
        options: {'Cone': true, 'Pyramid': false, 'Sphere': false, 'Sylinder': false}),
         Question(
        id: '20',
        title: ' Do you like this app?',
        options: {'No': true, 'Yes': true, 'I think so': true, 'I dont know': true}),
  ];

  int currentIndex = 0;
  int score = 0;
  bool isOptionSelected = false;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (currentIndex == questions.length - 1) {
      showDialog(
        context: context,
        builder: (ctx) => ResultBox(
          score: score,
          totalQuestions: questions.length,
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
              question: questions[currentIndex].title,
              indexAction: currentIndex,
              totalQuestions: questions.length,
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            ...questions[currentIndex].options.entries.map((entry) {
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
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
