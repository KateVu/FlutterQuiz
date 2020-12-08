import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal.shade700,
          title: Text('Quiz App'),
        ),
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuestionBank questionBank = QuestionBank();
  List<Widget> score = [];

  void checkAnswer(bool answer) {
    setState(() {
      if (!questionBank.isFinished) {
        //check answer and update score icons
        if (questionBank.isCorrectAnswer(answer)) {
          score.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          print('add icon');
          score.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      }
      questionBank.checkIsFinished();
      //if isFinished -> display alert
      if (questionBank.isFinished) {
        Alert(
          context: context,
          type: AlertType.error,
          title: 'CONGRAT!!!',
          desc: "You finished the quiz, click Reset to do it again.",
          buttons: [
            DialogButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                questionBank.reset();
                score = [];
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        questionBank.moveNextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                questionBank.questionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: Text(
                    'true'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      checkAnswer(false);
                    });
                  },
                  child: Text(
                    'false'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: score,
          ),
        ),
      ],
    );
  }
}
