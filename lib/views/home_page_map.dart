import 'package:flutter/material.dart';

class HomePageMap extends StatelessWidget {
  final Function changeView;
  const HomePageMap({super.key, required this.changeView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            changeView();
          },
          child: const Text('Map home'),
        ),
      ),
    );
  }
}