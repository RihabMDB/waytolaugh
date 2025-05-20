import 'package:flutter/material.dart';
import 'package:waytolaugh/pages/joke_page.dart';
import 'package:waytolaugh/pages/favorite_jokes.dart';
import 'models/joke_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line

      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _counter = 0;
  late Future<Joke> futureJoke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
          IconButton(color: Colors.black,
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteJokes()),
                    )
                  },
              icon: Icon(Icons.format_list_bulleted)),
        ]),
        // backgroundColor: Color.fromARGB(31, 191, 18, 18),
        body: Container(
          child: JokeView(),
          /* Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("data"),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.navigate_next)),
      ],
    )*/
        ));
  }
}
