import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateEventViewState();
  }
}

class _CreateEventViewState extends State<CreateEventView> {
  TextEditingController eventDateInput = TextEditingController();
  TimeOfDay? eventTime = TimeOfDay.now();
  bool isDirtChecked = false;
  bool isRoadChecked = false;
  bool isGravelChecked = false;
  bool isCyclePathChecked = false;
  bool isPavingStonesChecked = false;
  bool isOthersChecked = false;
  bool isPublic = false;
  bool isPrivate = false;
  bool isBikeCity = false;
  bool isBikeAllTerrain = false;
  bool isBikeGravel = false;
  bool isBikeBMX = false;

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
                        _buildDatePicker("Date", 0, 0),
                        _buildTimePicker("Heure", 0, 0)
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
                    Row(children: [
                      Column(children: [
                        _buildCheckbox("Terre", isDirtChecked, 0, 0),
                        _buildCheckbox("Gravier", isGravelChecked, 0, 0),
                        _buildCheckbox("Pavés", isPavingStonesChecked, 0, 0)
                      ]),
                      Column(children: [
                        _buildCheckbox("Route", isRoadChecked, 0, 0),
                        _buildCheckbox(
                            "Piste cyclable", isCyclePathChecked, 0, 0),
                        _buildCheckbox("Autres", isOthersChecked, 0, 0)
                      ])
                    ]),
                    const Divider(
                      indent: 100,
                      endIndent: 100,
                      color: Colors.black,
                    ),
                    _buildCategoryTitle("Visibilité"),
                    Row(
                      children: [
                        _buildCheckbox("Public", isPublic, 0, 0),
                        _buildCheckbox("Privé", isPrivate, 0, 0),
                      ],
                    ),
                    const Divider(
                      indent: 100,
                      endIndent: 100,
                      color: Colors.black,
                    ),
                    _buildCategoryTitle("Type de vélo"),
                    Row(
                      children: [
                        Column(children: [
                          _buildCheckbox("Ville", isBikeCity, 0, 0),
                          _buildCheckbox("Gravel", isBikeGravel, 0, 0),
                        ]),
                        Column(children: [
                          _buildCheckbox("BMX", isBikeBMX, 0, 0),
                          _buildCheckbox(
                              "Tout terrains", isBikeAllTerrain, 0, 0),
                        ])
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
          decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today,
                  color: CustomColorScheme.customOnSecondary)),
          style: const TextStyle(color: CustomColorScheme.customOnSecondary),
          readOnly: true,
          onTap: () async {
            DateTime? eventDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                barrierColor: CustomColorScheme.customBackground,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: CustomColorScheme.customSecondaryColor,
                        onPrimary: CustomColorScheme.customOnSecondary,
                        onSurface: CustomColorScheme.customOnSecondary,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: CustomColorScheme
                              .customOnSecondary, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                });
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

  Widget _buildTimePicker(String name, int height, int width) {
    return Row(children: <Widget>[
      ElevatedButton(
          child: Text(name, style: const TextStyle(color: Colors.black)),
          onPressed: () async {
            TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                barrierColor: CustomColorScheme.customBackground,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: CustomColorScheme.customSecondaryColor,
                        onPrimary: CustomColorScheme.customOnSecondary,
                        onSurface: CustomColorScheme.customOnSecondary,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: CustomColorScheme
                              .customOnSecondary, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                });
            if (time != null) {
              setState(() {
                eventTime = time;
              });
            }
          }),
      if (eventTime != null)
        Text(formatTimeOfDay(eventTime),
            style: const TextStyle(
              color: CustomColorScheme.customOnSecondary,
            )),
    ]);
  }

  Widget _buildCheckbox(String name, bool value, int height, int width) {
    return Row(
      children: [
        Text(name, style: const TextStyle(color: Colors.black)),
        Checkbox(
            value: value,
            checkColor: Colors.red,
            fillColor: MaterialStateProperty.resolveWith(getCheckboxColor),
            onChanged: (bool? change) {
              setState(() {
                value = change!;
              });
            }),
      ],
    );
  }

  String formatTimeOfDay(TimeOfDay? t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t!.hour, t.minute);
    return DateFormat("HH:mm").format(dt);
  }

  Color getCheckboxColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return CustomColorScheme.customSecondaryColor;
    }
    return CustomColorScheme.customPrimaryColor;
  }
}
