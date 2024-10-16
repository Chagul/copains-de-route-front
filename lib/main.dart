import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/cubit/navigation/navigation_cubit.dart';
import 'package:copains_de_route/cubit/navigation/navigation_state.dart';
import 'package:copains_de_route/cubit/position/position_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/create_itinerary_page.dart';
import 'package:copains_de_route/views/home_page.dart';
import 'package:copains_de_route/views/login_screen.dart';
import 'package:copains_de_route/views/my_events_page.dart';
import 'package:copains_de_route/views/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();
  runApp(BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(VerifyTokenState())..verifyToken(),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PositionCubit()..initPosition()),
          BlocProvider(
              create: (context) => NavigationCubit(NavigationInitialState())),
        ],
        child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('fr')
            ],
            theme: ThemeData(colorScheme: const CustomColorScheme()),
            home: BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) {
                return current is! UserRefreshState && current is! FriendState;
              },
              builder: (context, state) {
                if (state is TokenValidState) {
                  context.read<LoginCubit>().getUser();
                  return const LoadingWidget();
                }
                if (state is UserLoadedState) {
                  return _buildMainApp();
                }
                return const LoginScreen();
              },
            )));
  }

  Widget _buildMainApp() {
    return BlocConsumer<NavigationCubit, NavigationState>(
        listener: (context, state) {
      if (state is NavigationToState) {
        selectedPageIndex = state.index;
      }
    }, builder: (context, state) {
      return Scaffold(
        body: const [
          HomePage(),
          MyEventsPage(),
          CreateItineraryPage(),
          ProfileView()
        ][selectedPageIndex],
        bottomNavigationBar: NavigationBar(
          indicatorColor: CustomColorScheme.customSecondaryColor,
          backgroundColor: CustomColorScheme.customBackground,
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            BlocProvider.of<NavigationCubit>(context).navigateTo(index);
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon:
                  Icon(Icons.home, color: CustomColorScheme.customPrimaryColor),
              label: 'Accueil',
            ),
            NavigationDestination(
              icon: ImageIcon(
                AssetImage('assets/icon_my_itinerary.png'),
                color: CustomColorScheme.customPrimaryColor,
              ),
              label: 'Mes événements',
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
    });
  }
}
