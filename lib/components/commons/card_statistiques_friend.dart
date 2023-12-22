import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CardStatiquesFriend extends StatelessWidget {
  const CardStatiquesFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children :[
       Card(
        color: CustomColorScheme.customBackground, // Couleur de la Card en rouge
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu verticalement
            children: [
              Text(
                "Statistiques :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [
                  Icon(Icons.directions_bike),
                  SizedBox(width: 10),
                  Text(
                    "A participé à 3 événements",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.pin_drop),
                  SizedBox(width: 10),
                  Text(
                    "A créé à 2 événements",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.map),
                  SizedBox(width: 10),
                  Text(
                    "A parcouru à 100 km",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.co2),
                  SizedBox(width: 10),
                  Text(
                    "A économisé 1000 g de CO2",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                ]),
              ]),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      ],
    );
  }
}
