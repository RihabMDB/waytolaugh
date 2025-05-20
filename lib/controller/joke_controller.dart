import 'dart:convert';

import 'package:waytolaugh/models/joke_model.dart';
import 'package:http/http.dart' as http;

class JokeController {
  Future<Joke?> getJoke() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/jokes/random'));
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
