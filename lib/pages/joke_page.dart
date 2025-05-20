import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waytolaugh/controller/joke_controller.dart';
import 'package:waytolaugh/entities/database_helper.dart';
import 'package:waytolaugh/models/joke_model.dart';

class JokeView extends StatefulWidget {
  const JokeView({super.key});

  @override
  State<JokeView> createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  DatabaseHelper db = DatabaseHelper();

  List<Joke> list_jokes = [];
  Joke? joke, loaded_joke;
  bool isLoaded = false;
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
    loadJoke();
  }

  Future<void> loadJoke() async {
    final jokeController = JokeController();
    joke = await jokeController.getJoke();
    setState(() {
      isLoaded = true;
      loaded_joke = joke;
      isPressed = false;
    });
  }

  addToFavorie(Joke joke) {
    if (!list_jokes.contains(joke)) {
      list_jokes.add(joke);
      db.insertJoke(joke);

      setState(() => isPressed = !isPressed);
    } else {
      setState(() => isPressed = !isPressed);
      db.deleteJoke(joke.id);
      list_jokes.remove(joke);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded && joke != null
        ? SafeArea(
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 120, 50, 120),
              // clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 15.0,
                  spreadRadius: 4.0,
                ), //BoxShadow
              ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                  color: Color.fromARGB(255, 240, 235, 235)),
                              child: Text(
                                loaded_joke?.setup ?? 'No setup',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              //margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Color.fromARGB(255, 240, 235, 235)),
                              child: Text(
                                loaded_joke?.punchline ?? 'No punchline',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://cdn.pixabay.com/animation/2022/08/17/03/45/03-45-12-425_512.gif',
                          placeholder: (BuildContext context, String url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => {addToFavorie(joke!)},
                              icon: Icon(
                                  isPressed
                                      ? Icons.favorite
                                      : Icons.favorite_border_sharp,
                                  size: 30)),
                          IconButton(
                              onPressed: () => {
                                    loadJoke(),
                                  },
                              icon: const Icon(size: 30, Icons.refresh)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
