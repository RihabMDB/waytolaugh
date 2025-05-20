import 'package:flutter/material.dart';

import '../models/joke_model.dart';

class FavoriteCard extends StatefulWidget {
  final Joke data;
  const FavoriteCard({super.key, required this.data});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(35),
      //padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),

      child: Column(
        children: [
          Text(widget.data.setup),
          //SizedBox(height: 15),
          Text(widget.data.punchline)
        ],
      ),
    );
  }
}
