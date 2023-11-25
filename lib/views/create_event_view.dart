import 'package:copains_de_route/components/custom_category_title.dart';
import 'package:copains_de_route/components/custom_date_picker.dart';
import 'package:copains_de_route/components/custom_number_input.dart';
import 'package:copains_de_route/components/custom_switch_input.dart';
import 'package:copains_de_route/components/custom_text_input.dart';
import 'package:copains_de_route/components/custom_time_picker.dart';
import 'package:copains_de_route/components/custom_checkbox.dart';
import 'package:flutter/material.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateEventViewState();
  }
}

class _CreateEventViewState extends State<CreateEventView> {
  TextEditingController eventNameInput = TextEditingController();
  TextEditingController eventDescriptionInput = TextEditingController();
  TextEditingController eventNbParticipantsInput = TextEditingController();
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
                      const CustomCategoryTitle(
                          name: 'Détails de l\'événement'),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          name: 'Nom de l\'événement',
                          minLines: 1,
                          maxLines: 1,
                          value: eventNameInput),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: CustomDatePicker(
                                  name: 'Date', input: eventDateInput)),
                          Expanded(
                              child: CustomTimePicker(
                                  name: 'Heure', time: eventTime))
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          name: 'Description',
                          minLines: 5,
                          maxLines: 10,
                          value: eventDescriptionInput),
                      const SizedBox(height: 20),
                      CustomNumberInput(
                          name: 'Nombre de participants maximum',
                          value: eventNbParticipantsInput),
                      const Divider(
                        indent: 100,
                        endIndent: 100,
                        color: Colors.black,
                      ),
                      const CustomCategoryTitle(name: 'Type de route'),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCheckbox(
                                      name: "Piste cyclable",
                                      value: isCyclePathChecked,
                                      height: 0,
                                      width: 0),
                                  CustomCheckbox(
                                      name: "Gravier",
                                      value: isGravelChecked,
                                      height: 0,
                                      width: 0),
                                  CustomCheckbox(
                                      name: "Pavés",
                                      value: isPavingStonesChecked,
                                      height: 0,
                                      width: 0)
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCheckbox(
                                      name: "Route",
                                      value: isRoadChecked,
                                      height: 0,
                                      width: 0),
                                  CustomCheckbox(
                                      name: "Terre",
                                      value: isDirtChecked,
                                      height: 0,
                                      width: 0),
                                  CustomCheckbox(
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
                      const CustomCategoryTitle(name: 'Visibilité'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSwitchInput(
                              name1: 'Privé', name2: 'Public', value: isPublic)
                        ],
                      ),
                      const Divider(
                        indent: 100,
                        endIndent: 100,
                        color: Colors.black,
                      ),
                      const CustomCategoryTitle(name: 'Type de vélo'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomCheckbox(
                                      name: "Tout terrains ",
                                      value: isBikeCity,
                                      height: 0,
                                      width: 0),
                                  CustomCheckbox(
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
                                  CustomCheckbox(
                                      name: "BMX  ",
                                      value: isBikeBMX,
                                      height: 0,
                                      width: 0),
                                  CustomCheckbox(
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

  void _submitForm() {}

  void _cancel() {}
}
