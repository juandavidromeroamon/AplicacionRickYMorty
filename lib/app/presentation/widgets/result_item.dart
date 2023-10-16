import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';

class ResultItem extends StatelessWidget {
  final dynamic result;

  ResultItem({required this.result});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (result is Character && result.image.isNotEmpty)
          ? Image.network(result.image)
          : Container(
              width: 50,
              height: 50,
              color: result is Character ? Colors.blue : Colors.red,
            ),
      title: Text(result.name),
    );
  }
}
