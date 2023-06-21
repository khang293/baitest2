import 'package:flutter/material.dart';
import 'database/database_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokesPage(),
    );
  }
}

class JokesPage extends StatefulWidget {
  @override
  _JokesPageState createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  List<Map<String, dynamic>> _jokes = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  void _loadJokes() async {
    final jokes = await _databaseProvider.getJokes();
    setState(() {
      _jokes = jokes;
    });
  }

  void _updateRating(int id, int rating) async {
    await _databaseProvider.updateJokeRating(id, rating);
    setState(() {
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= _jokes.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Jokes App'),
        ),
        body: Center(
          child: Text("That's all the jokes for today! \n Come back another day!"),
        ),
      );
    }

    final currentJoke = _jokes[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentJoke['content'],
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _updateRating(currentJoke['id'], 1),
                child: Text('This is Funny!'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _updateRating(currentJoke['id'], -1),
                child: Text('This is not Funny'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
