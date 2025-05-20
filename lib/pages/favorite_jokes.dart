import 'package:flutter/material.dart';
import 'package:waytolaugh/entities/database_helper.dart';

import '../models/joke_model.dart';

class FavoriteJokes extends StatefulWidget {
  const FavoriteJokes({super.key});

  @override
  State<FavoriteJokes> createState() => _FavoriteJokesState();
}

class _FavoriteJokesState extends State<FavoriteJokes> {
  final DatabaseHelper db = DatabaseHelper();
  late Future<List<Joke>?> _favoriteListFuture;
  List<Joke> _favoriteList = [];
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    _favoriteListFuture = db.getAllJokes();
    _favoriteListFuture.then((items) {
      setState(() {
        _favoriteList = items!;
      });
    });
  }

  void deleteJoke(Joke joke) {
    db.deleteJoke(joke.id);
    setState(() {
      _favoriteList
          .remove(joke); // This updates the UI without refetching from the DB
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Joke>?>(
        future: _favoriteListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.all(15),
                  itemBuilder: (context, index) =>
                      favoriteCard(snapshot.data![index]));
            }
            return const Center(
              child: Text('No favorites yet'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget favoriteCard(Joke joke) {
    //print(widget.data);
    return Container(
        // clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow),
            color: Colors.white,
            borderRadius: BorderRadius.circular(25)),
        child: ListTile(
            title: Text(joke.setup),
            //subtitle: Text(joke.id.toString()),
            trailing: Container(
              width: 30,
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 240, 228, 122),
                ),
                onPressed: () => deleteJoke(joke),
              ),
            )));

    /*Column(
        children: [
          Text(joke.setup),
          //SizedBox(height: 15),
          Text(joke.punchline)
        ],
      ),*/
  }
}
