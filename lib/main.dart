import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
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
  
  List<Icon>scoreKeeper = [];

  // List<String> questions =[
  //   "You can lead a cow down stairs but not up stairs.",
  //   "Approximately one quarter of human bones are in the feet.",
  //   "A slug\'s blood is green."
  // ];

  // List<bool> answers = [
  //    false,
  //    true,
  //    true
  // ];

  // Question q1 = Question(q: "You can lead a cow down stairs but not up stairs.",a: false)

  

   int questionNum = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionBank[questionNum].questionText != null?
                quizBrain.questionBank[questionNum].questionText!
                : "now other questions",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green
                ),
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                setState(() {
                bool correctAnswer = quizBrain.questionBank[questionNum].questionAnswer!;
                if(correctAnswer== true){
                  scoreKeeper.add(
                  Icon(Icons.check, color: Colors.green,)
                );
                }else {
                  scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
                }
                if( questionNum < quizBrain.questionBank.length -1 ){
                questionNum++;
                } else {
                  // Quiz completed - show completion dialog
                  Future.delayed(Duration(milliseconds: 100), () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Quiz Completed!'),
                          content: Text('You have completed all questions.\n\nCorrect Answers: ${scoreKeeper.where((icon) => icon.icon == Icons.check).length}/${quizBrain.questionBank.length}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Optionally restart the quiz
                                setState(() {
                                  questionNum = 0;
                                  scoreKeeper = [];
                                });
                              },
                              child: Text('Restart Quiz'),
                            ),
                          ],
                        );
                      },
                    );
                  });
                }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  bool correctAnswer = quizBrain.questionBank[questionNum].questionAnswer!;
                  if(correctAnswer== false){
                  scoreKeeper.add(
                  Icon(Icons.check, color: Colors.green,)
                );
                }else {
                  scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
                }

                if ( questionNum < quizBrain.questionBank.length -1){
                    questionNum++;
                } else {
                  // Quiz completed - show completion dialog
                  Future.delayed(Duration(milliseconds: 100), () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Quiz Completed!'),
                          content: Text('You have completed all questions.\n\nCorrect Answers: ${scoreKeeper.where((icon) => icon.icon == Icons.check).length}/${quizBrain.questionBank.length}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Optionally restart the quiz
                                setState(() {
                                  questionNum = 0;
                                  scoreKeeper = [];
                                });
                              },
                              child: Text('Restart Quiz'),
                            ),
                          ],
                        );
                      },
                    );
                  });
                }
                });
              },
            ),
          ),
        ),
        Row(children: scoreKeeper),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
