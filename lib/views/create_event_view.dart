import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Builder(
          builder: (context) => Form(
                child: Column(
                  children: [
                    _buildCategoryTitle("Détails de l'événement"),
                    _buildTextInputField("Nom de l'événement", 0, 0),
                    const Column(
                      children: [
                        // calendar makes it a stateful widget https://www.fluttercampus.com/guide/39/how-to-show-date-picker-on-textfield-tap-and-get-formatted-date/
                        // time picker makes it a stateful widget https://api.flutter.dev/flutter/material/showTimePicker.html
                      ],
                    ),
                    _buildTextInputField("Description", 0, 0),
                    _buildTextInputField(
                        "Nombre de participants maximum", 0, 0),
                    const Divider(
                      indent: 100,
                      endIndent: 100,
                      color: Colors.black,
                    ),
                    _buildCategoryTitle("Type de route"),
                    const Column(
                      children: [
                        // calendar makes it a stateful widget https://www.fluttercampus.com/guide/39/how-to-show-date-picker-on-textfield-tap-and-get-formatted-date/
                        // time picker makes it a stateful widget https://api.flutter.dev/flutter/material/showTimePicker.html
                      ],
                    ),
                    const Divider(
                      indent: 100,
                      endIndent: 100,
                      color: Colors.black,
                    ),
                    _buildCategoryTitle("Visibilité"),
                    const Column(
                      children: [
                        // checkbox makes it a stateful widget https://api.flutter.dev/flutter/material/Checkbox-class.html
                      ],
                    ),
                    const Divider(
                      indent: 100,
                      endIndent: 100,
                      color: Colors.black,
                    ),
                    _buildCategoryTitle("Type de vélo"),
                    const Column(
                      children: [
                        // checkbox makes it a stateful widget https://api.flutter.dev/flutter/material/Checkbox-class.html
                      ],
                    ),
                  ],
                ),
              )),
    );
  }

  Widget _buildCategoryTitle(String name) {
    return Text(name,
        style: const TextStyle(
            color: CustomColorScheme.customPrimaryColor,
            fontWeight: FontWeight.bold));
  }

  Widget _buildTextInputField(String name, int height, int width) {
    return Column(children: [
      Text(
        name,
        style: const TextStyle(color: Colors.black),
      ),
      TextFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: CustomColorScheme.customOnPrimary,
        ),
        style: const TextStyle(color: CustomColorScheme.customOnSecondary),
      )
    ]);
  }
}
