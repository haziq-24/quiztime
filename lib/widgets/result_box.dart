import 'package:flutter/material.dart';
import '../constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onPressed,
  });

  final int score;
  final int totalQuestions;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String motivationalMessage = score == totalQuestions
        ? 'Congratulations! You got a perfect score!'
        : 'Sokay at least you try right?';

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text(
        'Quiz Completed !',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              '$score',
              style: const TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'out of $totalQuestions',
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            motivationalMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            ),
            child: const Text(
              'Start Over',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
