import '../utils/utils.dart';

class Joke {
  int id;
  String setup, punchline;
  Joke({required this.id, required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json["id"],
      setup: json["setup"],
      punchline: json["punchline"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Utils.columnId: id,
      Utils.columnSetup: setup,
      Utils.columnPunchline: punchline
    };
  }

  factory Joke.fromMap(Map<dynamic, dynamic> map) {
    return Joke(
      id: map['id']?.toInt() ?? 0,
      setup: map['setup'] ?? '',
      punchline: map['punchline'] ?? '',
    );
  }
}
