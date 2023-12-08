import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromARGB(255, 112, 83, 40)),
      ),
      home: QuizScreen(),
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Quiz App'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Quiz App!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
              child: Text('Start Quiz', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _submitted = false;

  List<Map<String, dynamic>> questions = [
  {
    'question': 'Which planet is known as the "Red Planet"?',
    'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
    'correctIndex': 1,
  },
  {
    'question': 'What is the largest moon of Jupiter?',
    'options': ['Io', 'Europa', 'Ganymede', 'Callisto'],
    'correctIndex': 2,
  },
  {
    'question': 'What is the distance between the Earth and the Sun called?',
    'options': ['Astronomical Unit', 'Light Year', 'Parsec', 'Solar Radius'],
    'correctIndex': 0,
  },
  {
    'question': 'Who was the first human to step on the moon?',
    'options': ['Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'Michael Collins'],
    'correctIndex': 0,
  },
  {
    'question': 'Which galaxy is the Milky Way closest to?',
    'options': ['Andromeda', 'Triangulum', 'Orion', 'Sombrero'],
    'correctIndex': 0,
  },
  {
    'question': 'What is the name of the first artificial satellite launched into Earth\'s orbit?',
    'options': ['Explorer 1', 'Sputnik 1', 'Vanguard 1', 'Telstar'],
    'correctIndex': 1,
  },
  {
    'question': 'Which space agency launched the Hubble Space Telescope?',
    'options': ['NASA', 'ESA', 'ISRO', 'Roscosmos'],
    'correctIndex': 0,
  },
  {
    'question': 'What is the main component of the sun?',
    'options': ['Hydrogen', 'Helium', 'Oxygen', 'Carbon'],
    'correctIndex': 0,
  },
  // Add more space-related questions...
];

  void _checkAnswer(int selectedIndex) {
  if (_currentIndex <= questions.length - 1 && !_submitted) {
    if (selectedIndex == questions[_currentIndex]['correctIndex']) {
      setState(() {
        _score++;
      });
    }
  }
}


  void _nextQuestion() {
  setState(() {
    if (_currentIndex < questions.length - 1 && !_submitted) {
      _currentIndex++;
    } else if (_currentIndex == questions.length - 1) {
      _submitted = true;
      _submitQuiz();
    }
  });
}


  void _previousQuestion() {
  setState(() {
    if (_currentIndex > 0 && !_submitted) {
      _currentIndex--;
    }
  });
}

  void _submitQuiz() {
  setState(() {
    _submitted = true;
  });

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Quiz Results'),
      content: Text('Your Score: $_score / ${questions.length}'),
      actions: [
        TextButton(
          onPressed: () {
            _restartQuiz(); // Call _restartQuiz when Restart Quiz is pressed
            Navigator.pop(context);
          },
          child: Text('Restart Quiz', style: TextStyle(color: Colors.teal)),
        ),
      ],
    ),
  );
}


  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Quiz App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              title: Text('Home', style: TextStyle(color: Colors.teal)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Add more drawer items...
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ...((questions[_currentIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: _submitted
                                  ? null
                                  : () {
                                      _checkAnswer(entry.key);
                                      _nextQuestion();
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.teal,
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(entry.value),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _previousQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    child:
                        Text('Previous', style: TextStyle(color: Colors.white)),
                  ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? null
                      : () {
                          _submitQuiz();
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? () {
                          _restartQuiz();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  child: Text('Restart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_submitted)
              Center(
                child: Text(
                  'Your Score: $_score / ${questions.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_submitted) {
            _nextQuestion();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.teal,
      ),
    );
  }
}