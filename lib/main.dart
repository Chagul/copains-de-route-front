import 'package:copains_de_route/cubit/position/position_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/create_itinerary_page.dart';
import 'package:copains_de_route/views/home_page.dart';
import 'package:copains_de_route/views/login_screen.dart';
import 'package:copains_de_route/views/my_itinerary_page.dart';
import 'package:copains_de_route/views/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;

  bool userIsLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionCubit()..initPosition(),
      child: MaterialApp(
        home: userIsLoggedIn ? _buildMainApp() : const LoginScreen(),
        theme: ThemeData(colorScheme: const CustomColorScheme()),
      ),
    );
  }

  Widget _buildMainApp() {
    return Scaffold(
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
            icon: ImageIcon(
              AssetImage('assets/icon_my_itinerary.png'),
              color: CustomColorScheme.customPrimaryColor,
            ),
            label: 'Mes itinéraires',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.pin_drop,
              color: CustomColorScheme.customPrimaryColor,
            ),
            label: 'Créer',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: CustomColorScheme.customPrimaryColor,
            ),
            icon: Icon(
              Icons.person,
              color: CustomColorScheme.customPrimaryColor,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
