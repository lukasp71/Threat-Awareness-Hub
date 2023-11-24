import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: QuizPage()));

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<String> questions = [
    'What does a Grey Hat Hacker do?',
    'What is a benefit of a White Hat Hacker?',
    'Why are Black Hat Hackers Malicious?',
    'What is a tool that Ethical Hacker use?',
    'Which historical event significantly impacted the evolution of cybersecurity?',
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
      'The Morris Worm',
      'The invention of the internet',
      'The Y2K bug',
      'The creation of the first antivirus software',
    ],  
  ];

  final List<int> correctAnswers = [
    1,
    2,
    3,
    3,
    0,
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