import 'package:copains_de_route/components/custom_category_title.dart';
import 'package:copains_de_route/components/custom_date_picker.dart';
import 'package:copains_de_route/components/custom_number_input.dart';
import 'package:copains_de_route/components/custom_switch_input.dart';
import 'package:copains_de_route/components/custom_text_input.dart';
import 'package:copains_de_route/components/custom_time_picker.dart';
import 'package:copains_de_route/components/custom_checkbox.dart';
import 'package:copains_de_route/model/event_request.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                            name: 'Heure',
                            time: eventTime,
                            updateTime: updateTimeValue,
                          ))
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
                                    updateBoolean: updateIsCyclePathChecked,
                                  ),
                                  CustomCheckbox(
                                    name: "Gravier",
                                    value: isGravelChecked,
                                    updateBoolean: updateIsGravelChecked,
                                  ),
                                  CustomCheckbox(
                                    name: "Pavés",
                                    value: isPavingStonesChecked,
                                    updateBoolean: updateIsPavingStonesChecked,
                                  )
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCheckbox(
                                    name: "Route",
                                    value: isRoadChecked,
                                    updateBoolean: updateIsRoadChecked,
                                  ),
                                  CustomCheckbox(
                                    name: "Terre",
                                    value: isDirtChecked,
                                    updateBoolean: updateIsDirtChecked,
                                  ),
                                  CustomCheckbox(
                                    name: "Autres",
                                    value: isOthersChecked,
                                    updateBoolean: updateIsOthersChecked,
                                  )
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
                            name1: 'Privé',
                            name2: 'Public',
                            value: isPublic,
                            updateBoolean: updateSwitchValue,
                          )
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
                                    value: isBikeAllTerrain,
                                    updateBoolean: updateIsBikeAllTerrain,
                                  ),
                                  CustomCheckbox(
                                    name: "Gravel",
                                    value: isBikeGravel,
                                    updateBoolean: updateIsBikeGravel,
                                  ),
                                ]),
                          ),
                          IntrinsicWidth(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomCheckbox(
                                    name: "BMX  ",
                                    value: isBikeBMX,
                                    updateBoolean: updateIsBikeBMX,
                                  ),
                                  CustomCheckbox(
                                    name: "Ville",
                                    value: isBikeCity,
                                    updateBoolean: updateIsBikeCity,
                                  ),
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

  void _submitForm() async {
    // TODO add API call and put validators on text fields
    Dio dio = Dio();

    DateTime eventDate = DateFormat("yyy-MM-dd hh:mm").parse(
        "${eventDateInput.text} ${FormatUtils.formatTimeOfDay(eventTime)}");
    String eventDateString =
        DateFormat("yyyy-MM-dd hh:mm:ss").format(eventDate);
    List<String> roadTypes = _getRoadTypesList();
    List<String> bikeTypes = _getBikeTypesList();
    String visibility = _getVisibilityValue();

    EventRequest data = EventRequest(
        promoter: 0,
        maxParticipants: int.parse(eventNbParticipantsInput.text),
        startTime: eventDateString,
        roadType1: roadTypes[0],
        roadType2: roadTypes[1],
        roadType3: roadTypes[2],
        startPoint: "Lat:0;Lon:0",
        endPoint: "Lat:1;Lon:1",
        name: eventNameInput.text,
        description: eventDescriptionInput.text,
        bikeType1: bikeTypes[0],
        bikeType2: bikeTypes[1],
        visibility: visibility);

    var response = await dio.post("http://localhost:8080/events",
        data: data, options: Options(contentType: Headers.jsonContentType));
    if (response.statusCode == 200) {
      print("done successfully");
    } else {
      print("error ${response.statusCode}");
    }
  }

  void _cancel() {}

  List<String> _getRoadTypesList() {
    List<String> roadTypesList = [];
    if (isDirtChecked) {
      roadTypesList.add('DIRT');
    }
    if (isRoadChecked) {
      roadTypesList.add('ROAD');
    }
    if (isGravelChecked) {
      roadTypesList.add('GRAVEL');
    }
    if (isCyclePathChecked) {
      roadTypesList.add('CYCLE_PATH');
    }
    if (isPavingStonesChecked) {
      roadTypesList.add('PAVING_STONES');
    }
    if (isOthersChecked) {
      roadTypesList.add('OTHERS');
    }
    return roadTypesList;
  }

  List<String> _getBikeTypesList() {
    List<String> bikeTypes = [];
    if (isBikeCity) {
      bikeTypes.add('CITY');
    }
    if (isBikeAllTerrain) {
      bikeTypes.add('ALL_TERRAIN');
    }
    if (isBikeGravel) {
      bikeTypes.add('GRAVEL');
    }
    if (isBikeBMX) {
      bikeTypes.add('BMX');
    }
    return bikeTypes;
  }

  String _getVisibilityValue() {
    return isPublic ? "PUBLIC" : "PRIVATE";
  }

  void updateIsDirtChecked(bool change) {
    setState(() {
      isDirtChecked = change;
    });
  }

  void updateIsRoadChecked(bool change) {
    setState(() {
      isRoadChecked = change;
    });
  }

  void updateIsGravelChecked(bool change) {
    setState(() {
      isGravelChecked = change;
    });
  }

  void updateIsCyclePathChecked(bool change) {
    setState(() {
      isCyclePathChecked = change;
    });
  }

  void updateIsPavingStonesChecked(bool change) {
    setState(() {
      isPavingStonesChecked = change;
    });
  }

  void updateIsOthersChecked(bool change) {
    setState(() {
      isOthersChecked = change;
    });
  }

  void updateIsPublic(bool change) {
    setState(() {
      isPublic = change;
    });
  }

  void updateIsBikeCity(bool change) {
    setState(() {
      isBikeCity = change;
    });
  }

  void updateIsBikeAllTerrain(bool change) {
    setState(() {
      isBikeAllTerrain = change;
    });
  }

  void updateIsBikeGravel(bool change) {
    setState(() {
      isBikeGravel = change;
    });
  }

  void updateIsBikeBMX(bool change) {
    setState(() {
      isBikeBMX = change;
    });
  }

  void updateTimeValue(TimeOfDay time) {
    setState(() {
      eventTime = time;
    });
  }

  void updateSwitchValue(bool change) {
    setState(() {
      isPublic = change;
    });
  }
}
