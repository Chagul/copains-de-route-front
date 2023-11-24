import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/components/checkbox_custom.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Builder(
          builder: (context) => SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      _buildCategoryTitle("Détails de l'événement"),
                      const SizedBox(height: 20),
                      _buildTextInputField("Nom de l'événement", 1, 1),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildDatePicker("Date", 0, 0)),
                          Expanded(child: _buildTimePicker("Heure", 0, 0))
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTextInputField("Description", 5, 10),
                      const SizedBox(height: 20),
                      _buildNumberInputField(
                          "Nombre de participants maximum", 0, 0),
                      const Divider(
                        indent: 100,
                        endIndent: 100,
                        color: Colors.black,
                      ),
                      _buildCategoryTitle("Type de route"),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckboxCustom(
                                      name: "Piste cyclable",
                                      value: isCyclePathChecked,
                                      height: 0,
                                      width: 0),
                                  CheckboxCustom(
                                      name: "Gravier",
                                      value: isGravelChecked,
                                      height: 0,
                                      width: 0),
                                  CheckboxCustom(
                                      name: "Pavés",
                                      value: isPavingStonesChecked,
                                      height: 0,
                                      width: 0)
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckboxCustom(
                                      name: "Route",
                                      value: isRoadChecked,
                                      height: 0,
                                      width: 0),
                                  CheckboxCustom(
                                      name: "Terre",
                                      value: isDirtChecked,
                                      height: 0,
                                      width: 0),
                                  CheckboxCustom(
                                      name: "Autres",
                                      value: isOthersChecked,
                                      height: 0,
                                      width: 0)
                                ])
                          ]),
                      const Divider(
                        indent: 100,
                        endIndent: 100,
                        color: Colors.black,
                      ),
                      _buildCategoryTitle("Visibilité"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_buildSwitchInput("Privé", "Public")],
                      ),
                      const Divider(
                        indent: 100,
                        endIndent: 100,
                        color: Colors.black,
                      ),
                      _buildCategoryTitle("Type de vélo"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CheckboxCustom(
                                      name: "Tout terrains ",
                                      value: isBikeCity,
                                      height: 0,
                                      width: 0),
                                  CheckboxCustom(
                                      name: "Gravel",
                                      value: isBikeGravel,
                                      height: 0,
                                      width: 0),
                                ]),
                          ),
                          IntrinsicWidth(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CheckboxCustom(
                                      name: "BMX  ",
                                      value: isBikeBMX,
                                      height: 0,
                                      width: 0),
                                  CheckboxCustom(
                                      name: "Ville",
                                      value: isBikeAllTerrain,
                                      height: 0,
                                      width: 0),
                                ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _cancel,
                            // style
                            child: const Text(
                              "Annuler",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _submitForm,
                            // style
                            child: const Text(
                              "Confirmer",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
    );
  }

  Widget _buildCategoryTitle(String name) {
    return Text(name,
        style: const TextStyle(
            color: CustomColorScheme.customPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18));
  }

  Widget _buildTextInputField(String name, int minLines, int maxLines) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      TextFormField(
        minLines: minLines,
        maxLines: maxLines,
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
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 70.0,
        child: TextField(
          decoration: const InputDecoration(
            filled: true,
            fillColor: CustomColorScheme.customOnPrimary,
          ),
          style: const TextStyle(color: CustomColorScheme.customOnSecondary),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      )
    ]);
  }

  Widget _buildDatePicker(String name, int height, int width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name, style: const TextStyle(color: Colors.black)),
        const SizedBox(width: 20.0),
        SizedBox(
          width: 140,
          child: TextField(
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
                            foregroundColor:
                                CustomColorScheme.customOnSecondary,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  });
              if (eventDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(eventDate);

                setState(() {
                  eventDateInput.text = formattedDate;
                });
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildTimePicker(String name, int height, int width) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
      const SizedBox(width: 20.0),
      if (eventTime != null)
        Text(formatTimeOfDay(eventTime),
            style: const TextStyle(
              color: CustomColorScheme.customOnSecondary,
            )),
    ]);
  }

  Widget _buildSwitchInput(String name1, String name2) {
    return Row(children: [
      Text(name1, style: const TextStyle(color: Colors.black)),
      Switch(
        value: isPublic,
        activeColor: CustomColorScheme.customPrimaryColor,
        onChanged: (bool value) {
          setState(() {
            isPublic = value;
          });
        },
      ),
      Text(name2, style: const TextStyle(color: Colors.black)),
    ]);
  }

  void _submitForm() {}

  void _cancel() {}

  String formatTimeOfDay(TimeOfDay? t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t!.hour, t.minute);
    return DateFormat("HH:mm").format(dt);
  }
}
