import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: AIandIoTQuizPage()));

class AIandIoTQuizPage extends StatefulWidget {
  @override
  _AIandIoTQuizPageState createState() => _AIandIoTQuizPageState();
}

class _AIandIoTQuizPageState extends State<AIandIoTQuizPage> {
  final List<String> questions = [
    'What is a common problem with AI?',
    'What can Machine Learning do for us?',
    'Now that we have AI, what is a potential concern we consider?',
    'What is something that most devices have that IoT devices do not?',
    'How can we make IoT devices less vulnerable?',
  ];

  final List<List<String>> choices = [
    [
      'It does not know anything',
      'Humans making a mistake when configurating it',
      'People do not know how to find AI tools',
      'AI hacks into systems',
    ],
    [
      'Give us new information',
      'Add new jobs',
      'Take outliers from preset rules and place it into collections of data with similarities or oddities.',
      'All of the above',
    ],
    [
      'Not enough experts in the field',
      'Lack of Jobs',
      'Lack of Creativity',
      'Increase of Technical Issues',
    ],
    [
      'Passwords',
      'Touch Screens',
      'Internet Capabilities',
      'Encryption',
    ],
    [
      'Put it on a Public Network',
      'Not using them',
      'Keep them on a seperate network',
      'All of the Above',
    ],  
  ];

  final List<int> correctAnswers = [
    1,
    2,
    0,
    3,
    2,
  ]; 
  late List<int?> userAnswers; 
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    userAnswers =
        List.filled(questions.length, null); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            questions.length,
            (index) {
              return Card(
                child: Column(
                  children: [
                    Text(questions[index]),
                    ...List.generate(
                      choices[index].length,
                      (choiceIndex) {
                        return RadioListTile<int>(
                          value: choiceIndex,
                          groupValue: userAnswers[index],
                          onChanged: isSubmitted
                              ? null
                              : (value) {
                                  setState(() {
                                    userAnswers[index] = value;
                                  });
                                },
                          title: Text(choices[index][choiceIndex]),
                          activeColor: isSubmitted
                              ? (choiceIndex == correctAnswers[index]
                                  ? Colors.green
                                  : (userAnswers[index] == choiceIndex
                                      ? Colors.red
                                      : null))
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isSubmitted = true;
          });
        },
        child: const Text('Submit'),
      ),
    );
  }
}
