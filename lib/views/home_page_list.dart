import 'package:flutter/material.dart';

class HomePageList extends StatelessWidget {
  final Function changeView;
  const HomePageList({super.key, required this.changeView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            changeView();
          },
          child: const Text('LIst home'),
        ),
      ),
    );
  }
}