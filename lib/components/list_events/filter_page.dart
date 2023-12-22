import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        const Text("Filtres",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
      ],
    ));
  }
}
