import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/create_itinerary_page.dart';
import 'package:copains_de_route/views/home_page.dart';
import 'package:copains_de_route/views/my_itinerary_page.dart';
import 'package:copains_de_route/views/profil_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const [
          HomePage(),
          MyIntineraryPage(),
          CreateItineraryPage(),
          ProfilPage()
        ][selectedPageIndex],
        bottomNavigationBar: NavigationBar(
          indicatorColor: CustomColorScheme.customSecondaryColor,
          backgroundColor: CustomColorScheme.customBackground,
        selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home, color: CustomColorScheme.customPrimaryColor),
              label: 'Accueil',
            ),
            NavigationDestination(
              icon: ImageIcon(AssetImage('assets/icon_my_itinerary.png'), color: CustomColorScheme.customPrimaryColor),
              label: 'Mes itinéraires',
            ),
            NavigationDestination(
              icon: Icon(Icons.pin_drop,color: CustomColorScheme.customPrimaryColor),
              label: 'Créer',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color: CustomColorScheme.customPrimaryColor),
              icon: Icon(Icons.person,  color: CustomColorScheme.customPrimaryColor),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}