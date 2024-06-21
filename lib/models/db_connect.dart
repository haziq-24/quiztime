import 'package:http/http.dart' as http;
import 'dart:convert';
import './question_model.dart';

class DBConnect {
  final Uri url = Uri.parse(
      'https://quizapp-669b9-default-rtdb.asia-southeast1.firebasedatabase.app/questions.json');

  Future<List<Question>> fetchQuestion() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        if (data == null) {
          throw FormatException('No data received');
        }

        List<Question> newQuestions = [];

        if (data is Map<String, dynamic>) {
          data.forEach((key, value) {
            var newQuestion = Question(
              id: key,
              title: value['title'] ?? '',
              options: _parseOptions(value['_options']),
            );
            newQuestions.add(newQuestion);
          });
        } else {
          throw FormatException('Unexpected data format');
        }

        return newQuestions;
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }

  Map<String, bool> _parseOptions(dynamic options) {
    if (options == null) {
      return {}; // or throw an error if options cannot be null
    }

    if (options is Map<String, dynamic>) {
      return options.map((key, value) => MapEntry(key, value as bool));
    } else {
      throw FormatException('Options should be a map of string to bool');
    }
  }
}
