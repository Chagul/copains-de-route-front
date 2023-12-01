import 'dart:async';

import 'package:copains_de_route/components/create_event/form/custom_category_title.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateEventFormFieldsBloc extends FormBloc<String, String> {
  final eventName = TextFieldBloc();
  final eventDate =
      InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final eventTime =
      InputFieldBloc<TimeOfDay?, Object>(initialValue: TimeOfDay.now());
  final eventDescription = TextFieldBloc();
  final eventMaxParticipants = TextFieldBloc();
  final eventIsPublic = BooleanFieldBloc();

  // Road Types
  final eventIsPathCyclePath = BooleanFieldBloc();
  final eventIsPathGravel = BooleanFieldBloc();
  final eventIsPathPavingStones = BooleanFieldBloc();
  final eventIsPathDirt = BooleanFieldBloc();
  final eventIsPathRoad = BooleanFieldBloc();
  final eventIsPathOthers = BooleanFieldBloc();

  // Bike Types
  final eventIsBikeAllTerrain = BooleanFieldBloc();
  final eventIsBikeGravel = BooleanFieldBloc();
  final eventIsBikeCity = BooleanFieldBloc();
  final eventIsBikeBMX = BooleanFieldBloc();

  CreateEventFormFieldsBloc() : super(autoValidate: false) {
    addFieldBlocs(fieldBlocs: [
      eventName,
      eventDate,
      eventTime,
      eventDescription,
      eventMaxParticipants,
      eventIsPublic,
      eventIsPathCyclePath,
      eventIsPathGravel,
      eventIsPathPavingStones,
      eventIsPathDirt,
      eventIsPathRoad,
      eventIsPathOthers,
      eventIsBikeAllTerrain,
      eventIsBikeGravel,
      eventIsBikeCity,
      eventIsBikeBMX,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() {
    throw UnimplementedError();
  }
}

class CreateEventForm extends StatelessWidget {
  const CreateEventForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return BlocProvider(
        create: (context) => CreateEventFormFieldsBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = context.read<CreateEventFormFieldsBloc>();

            return Theme(
                data: ThemeData(
                    colorScheme: const ColorScheme(
                        brightness: Brightness.light,
                        primary: CustomColorScheme.customPrimaryColor,
                        onPrimary: CustomColorScheme.customOnPrimary,
                        secondary: CustomColorScheme.customSecondaryColor,
                        onSecondary: CustomColorScheme.customOnSecondary,
                        error: CustomColorScheme.customError,
                        onError: CustomColorScheme.customOnError,
                        background: CustomColorScheme.customBackground,
                        onBackground: CustomColorScheme.customOnBackground,
                        surface: CustomColorScheme.customBackground,
                        onSurface: CustomColorScheme.customOnSecondary)),
                child: Scaffold(
                  body: SafeArea(
                    child: FormBlocListener<CreateEventFormFieldsBloc, String,
                        String>(
                      onSubmitting: (context, state) {
                        throw UnimplementedError();
                      },
                      onSuccess: (context, state) {
                        throw UnimplementedError();
                      },
                      onFailure: (context, state) {
                        throw UnimplementedError();
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CustomCategoryTitle(
                                    name: 'Détails de l\'événement'),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.eventName,
                                  autofillHints: const [
                                    AutofillHints.username,
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "Nom de l'événement",
                                  ),
                                  textColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          CustomColorScheme.customOnSecondary),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: DateTimeFieldBlocBuilder(
                                        dateTimeFieldBloc: formBloc.eventDate,
                                        format: DateFormat('yyyy-MM-dd'),
                                        initialDate: today,
                                        firstDate: today,
                                        lastDate: DateTime(today.year + 1,
                                            today.month, today.day),
                                        decoration: const InputDecoration(
                                          labelText: 'Date',
                                          prefixIcon:
                                              Icon(Icons.calendar_today),
                                        ),
                                        textColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => CustomColorScheme
                                                    .customOnSecondary),
                                      ),
                                    ),
                                    Expanded(
                                      child: TimeFieldBlocBuilder(
                                        timeFieldBloc: formBloc.eventTime,
                                        format: DateFormat('HH:mm'),
                                        initialTime: TimeOfDay.now(),
                                        decoration: const InputDecoration(
                                          labelText: 'Heure',
                                          prefixIcon: Icon(Icons.access_time),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.eventDescription,
                                  minLines: 5,
                                  maxLines: 10,
                                  decoration: const InputDecoration(
                                    labelText: "Description",
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.eventMaxParticipants,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelText: "Nombre de participants max",
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                const Divider(
                                  indent: 100,
                                  endIndent: 100,
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 10),
                                const CustomCategoryTitle(
                                    name: 'Type de route'),
                                const SizedBox(height: 10),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            child: CheckboxFieldBlocBuilder(
                                              booleanFieldBloc:
                                                  formBloc.eventIsPathRoad,
                                              body: const Text('Route'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 160,
                                            child: CheckboxFieldBlocBuilder(
                                              booleanFieldBloc:
                                                  formBloc.eventIsPathCyclePath,
                                              body:
                                                  const Text('Piste cyclable'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            child: CheckboxFieldBlocBuilder(
                                              booleanFieldBloc:
                                                  formBloc.eventIsPathGravel,
                                              body: const Text('Gravier'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 160,
                                            child: CheckboxFieldBlocBuilder(
                                              booleanFieldBloc:
                                                  formBloc.eventIsPathDirt,
                                              body: const Text('Terre'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            child: CheckboxFieldBlocBuilder(
                                              booleanFieldBloc: formBloc
                                                  .eventIsPathPavingStones,
                                              body: const Text('Pavés'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 160,
                                            child: CheckboxFieldBlocBuilder(
                                              booleanFieldBloc:
                                                  formBloc.eventIsPathOthers,
                                              body: const Text('Autres'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  indent: 100,
                                  endIndent: 100,
                                  color: Colors.black,
                                ),
                                const CustomCategoryTitle(name: 'Visibilité'),
                                const SizedBox(height: 10),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Privé'),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: 60,
                                            child: SwitchFieldBlocBuilder(
                                              booleanFieldBloc:
                                                  formBloc.eventIsPublic,
                                              body: const SizedBox(),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text('Public'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  indent: 100,
                                  endIndent: 100,
                                  color: Colors.black,
                                ),
                                const CustomCategoryTitle(name: 'Type de vélo'),
                                const SizedBox(height: 10),
                                Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 160,
                                                child: CheckboxFieldBlocBuilder(
                                                  booleanFieldBloc:
                                                      formBloc.eventIsBikeCity,
                                                  body: const Text('Ville'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 160,
                                                child: CheckboxFieldBlocBuilder(
                                                  booleanFieldBloc:
                                                      formBloc.eventIsBikeBMX,
                                                  body: const Text('BMX'),
                                                ),
                                              ),
                                            ]),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 160,
                                              child: CheckboxFieldBlocBuilder(
                                                booleanFieldBloc:
                                                    formBloc.eventIsBikeGravel,
                                                body: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text('Gravier'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 160,
                                              child: CheckboxFieldBlocBuilder(
                                                booleanFieldBloc: formBloc
                                                    .eventIsBikeAllTerrain,
                                                body: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                      'Tout terrains'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: formBloc.submit,
                                          child: const Text('Confirmer'),
                                        ),
                                      ]),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}


/*

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

    EventFormData data = EventFormData(
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

}
*/