import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'question.dart';

class QuestionBank {
  List<Question> _listQuestion = [
    Question('In school, Albert Einstein failed most of the subjects, except for physics and math', true),
    Question('The first song ever sung in the space was “Happy Birthday.', true),
    Question('The first country in the world to use postcards was the United States of America.', false),
    Question('A male canary tends to have a better singing voice than a female canary.', true),
    Question('Tea contains more caffeine than coffee and soda.', false),
    Question('Dogs have an appendix.', false),
    Question('Bill Gates is the founder of Amazon.', false),
  ];

  int _currentIndex = 0;

  bool isFinished = false;

  List<Widget> score = [];

  /// check if the quiz runs to last question
  /// return true if yes, false if no
  void checkIsFinished() {
    if (_currentIndex >= _listQuestion.length - 1) {
      isFinished = true;
    } else {
      isFinished = false;
    }
  }

  ///return current question
  String questionText() {
    return _listQuestion[_currentIndex].question;
  }

  bool isCorrectAnswer(bool answer) {
    if (answer == _listQuestion[_currentIndex].answer) {
      return true;
    } else {
      print('wrong');
      return false;
    }
  }

  void moveNextQuestion() {
    if (_currentIndex < _listQuestion.length - 1) {
      _currentIndex++;
    }
  }

  void reset() {
    _currentIndex = 0;
  }
}
