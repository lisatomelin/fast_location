import 'package:flutter/material.dart';

class SearchEmpty extends StatelessWidget {
  const SearchEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.directions,
          size: 80,
          color: Color.fromRGBO(156, 39, 176, 1),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Realize uma busca e localize seu destino",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}