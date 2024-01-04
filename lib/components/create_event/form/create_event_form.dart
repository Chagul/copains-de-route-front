import 'package:copains_de_route/cubit/create_event_global/create_itinerary_cubit.dart';
import 'package:copains_de_route/cubit/create_event/event_form_cubit.dart';
import 'package:copains_de_route/components/create_event/form/custom_category_title.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateEventForm extends StatelessWidget {
  const CreateEventForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return BlocProvider<EventFormBloc>(
        create: (context) => EventFormBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = context.read<EventFormBloc>();
            final createItineraryCubit = context.read<CreateItineraryCubit>();

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
                    child: FormBlocListener<EventFormBloc, String, String>(
                      onSubmitting: (context, state) {
                        BlocProvider.of<EventFormBloc>(context).addItinerary(
                            createItineraryCubit.selectedItinerary);
                        BlocProvider.of<EventFormBloc>(context)
                            .addSteps(createItineraryCubit.steps);
                        BlocProvider.of<EventFormBloc>(context).onSubmitting();
                      },
                      onSuccess: (context, state) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("L'événement a été créé")));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (r) => false);
                      },
                      onFailure: (context, state) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.failureResponse!)));
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
                                    fillColor: Colors.white,
                                    filled: true,
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
                                        locale: const Locale("fr", "FR"),
                                        dateTimeFieldBloc: formBloc.eventDate,
                                        format: DateFormat('yyyy-MM-dd'),
                                        initialDate: today,
                                        firstDate: today,
                                        lastDate: DateTime(today.year + 1,
                                            today.month, today.day),
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
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
                                    const VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: TimeFieldBlocBuilder(
                                        locale: const Locale("fr", "FR"),
                                        timeFieldBloc: formBloc.eventTime,
                                        format: DateFormat('HH:mm'),
                                        initialTime: TimeOfDay.now(),
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
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
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: "Description",
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.eventMaxParticipants,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelText: "Nombre de participants max",
                                    fillColor: Colors.white,
                                    filled: true,
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
                                              trackColor:
                                                  MaterialStateProperty.all(
                                                      CustomColorScheme
                                                          .customPrimaryColor),
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
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      CustomColorScheme
                                                          .customSecondaryColor)),
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
