import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile(this.letter, {super.key});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).colorScheme.primaryContainer,

        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Text(
          letter,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 21,
            fontWeight: FontWeight(900),
          ),
        ),
      ),
    );
  }
}

class WordRow extends StatelessWidget {
  final String word;

  const WordRow(this.word, {super.key});

  List<Tile> buildWordRow() {
    word.trim();
    List<Tile> tiles = List.empty(growable: true);
    List<String> characters = word.split('');

    for (String c in characters) {
      tiles.add(Tile(c));
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: buildWordRow());
  }
}
