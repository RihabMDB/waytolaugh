import 'dart:convert';

import 'package:waytolaugh/models/joke_model.dart';
import 'package:http/http.dart' as http;

class JokeApi {
// make async fnc that return a future of joke
  Future<Joke?> getJoke() async {
    // we can use http.get directly or make an instance of Client
    var client = new http.Client();
    final response = await client
        .get(Uri.parse('https://official-joke-api.appspot.com/jokes/random'));
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
