import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  State<StatefulWidget> createState() {
    return _CreateEventViewState();
  }
}

class _CreateEventViewState extends State<CreateEventView> {
  TextEditingController eventDateInput = TextEditingController();

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
                    Column(
                      children: [
                        // calendar makes it a stateful widget https://www.fluttercampus.com/guide/39/how-to-show-date-picker-on-textfield-tap-and-get-formatted-date/
                        _buildDatePicker("Date", 0, 0)
                        // time picker makes it a stateful widget https://api.flutter.dev/flutter/material/showTimePicker.html
                      ],
                    ),
                    _buildTextInputField("Description", 0, 0),
                    _buildNumberInputField(
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

  Widget _buildNumberInputField(String name, int height, int width) {
    return Column(children: [
      Text(
        name,
        style: const TextStyle(color: Colors.black),
      ),
      TextField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: CustomColorScheme.customOnPrimary,
        ),
        style: const TextStyle(color: CustomColorScheme.customOnSecondary),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      )
    ]);
  }

  Widget _buildDatePicker(String name, int height, int width) {
    return Column(
      children: [
        Text(name, style: const TextStyle(color: Colors.black)),
        TextField(
          controller: eventDateInput,
          decoration: const InputDecoration(icon: Icon(Icons.calendar_today)),
          readOnly: true,
          onTap: () async {
            DateTime? eventDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                barrierColor: CustomColorScheme.customPrimaryColor);

            if (eventDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(eventDate);

              setState(() {
                eventDateInput.text = formattedDate;
              });
            }
          },
        )
      ],
    );
  }
}
