import 'package:flutter/material.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';

class CardStatiquesFriend extends StatelessWidget {
  const CardStatiquesFriend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColorScheme.customBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouton de retour à la page précédente
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Retour à la page précédente
              },
            ),
            const Text(
              "Statistiques :",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: CustomColorScheme.customPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatRow(Icons.directions_bike, "A participé à 3 événements"),
                  _buildStatRow(Icons.pin_drop, "A créé à 2 événements"),
                  _buildStatRow(Icons.map, "A parcouru à 100 km"),
                  _buildStatRow(Icons.co2, "A économisé 1000 g de CO2"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
