import 'package:copains_de_route/components/profil/profile.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
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
  runApp(BlocProvider(
      create: (context) => LoginCubit(VerifyTokenState())..verifyToken(),
      child: const MyApp()));
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
        theme: ThemeData(colorScheme: const CustomColorScheme()),
        home: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is TokenValidState) {
              return _initMainApp(context);
            }
            return const LoginScreen();
          },
        ));
  }

  BlocProvider<PositionCubit> _initMainApp(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionCubit()..initPosition(),
      child: _buildMainApp(),
    );
  }

  Widget _buildMainApp() {
    return Scaffold(
      body: const [
        HomePage(),
        MyIntineraryPage(),
        CreateItineraryPage(),
        ProfileView()
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
