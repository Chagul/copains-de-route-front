import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/home_page_list.dart';
import 'package:copains_de_route/views/home_page_map.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int selectedPageIndex = 0;

  void _changeView() {
    if(selectedPageIndex == 0){
      setState(() {
        selectedPageIndex = 1;
      });
    } else {
      setState(() {
        selectedPageIndex = 0;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorScheme.customBackground,
      body: [
          HomePageList(changeView: _changeView),
          HomePageMap(changeView: _changeView)
        ][selectedPageIndex],
    );
  }
}
