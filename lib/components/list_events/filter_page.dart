import 'package:copains_de_route/components/create_event/form/custom_category_title.dart';
import 'package:copains_de_route/components/create_event/form/custom_checkbox.dart';
import 'package:copains_de_route/components/create_event/form/custom_date_picker.dart';
import 'package:copains_de_route/cubit/filter_form_cubit/filter_form_cubit.dart';
import 'package:copains_de_route/cubit/filter_form_cubit/filter_form_state.dart';
import 'package:copains_de_route/cubit/list_event/list_events_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          const Text("Filtres",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))
        ],
      ),
      BlocBuilder<FilterFormCubit, FilterFormState>(builder: (context, state) {
        return Flexible(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.black, width: 1)),
                                color: CustomColorScheme.customSurface,
                                child: Column(
                                  children: [
                                    const CustomCategoryTitle(name: "Date"),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(children: [
                                              SizedBox(
                                                  width: 150,
                                                  child: CustomDatePicker(
                                                      name: "Du",
                                                      input: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .startDateController))
                                            ]),
                                            Column(children: [
                                              SizedBox(
                                                  width: 150,
                                                  child: CustomDatePicker(
                                                      name: "Au",
                                                      input: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .endDateController))
                                            ]),
                                          ],
                                        )),
                                    const SizedBox(height: 20),
                                    const CustomCategoryTitle(name: "Distance"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(children: [
                                            SizedBox(
                                                width: 150,
                                                child: TextField(
                                                    onChanged: (value) => context
                                                        .read<FilterFormCubit>()
                                                        .changeDistanceMin(
                                                            value),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: TextStyle(
                                                        color: state
                                                                is FilterFormMinDistanceErrorState
                                                            ? Colors.red
                                                            : CustomColorScheme
                                                                .customOnSecondary),
                                                    decoration: const InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelText: "Min",
                                                        labelStyle: TextStyle(
                                                            color: CustomColorScheme
                                                                .customOnSecondary))))
                                          ]),
                                          Column(children: [
                                            SizedBox(
                                                width: 150,
                                                child: TextField(
                                                    onChanged: (value) => context
                                                        .read<FilterFormCubit>()
                                                        .changeDistanceMax(
                                                            value),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: TextStyle(
                                                        color: state
                                                                is FilterFormMaxDistanceErrorState
                                                            ? Colors.red
                                                            : CustomColorScheme
                                                                .customOnSecondary),
                                                    decoration: const InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelText: "Max",
                                                        labelStyle: TextStyle(
                                                            color: CustomColorScheme
                                                                .customOnSecondary))))
                                          ]),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const CustomCategoryTitle(
                                        name: "Type de route"),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomCheckbox(
                                                    name: "Terre",
                                                    value: context
                                                        .read<FilterFormCubit>()
                                                        .checkBoxPathDirt,
                                                    updateBoolean: (value) => {
                                                          context
                                                              .read<
                                                                  FilterFormCubit>()
                                                              .changePathDirt(
                                                                  value)
                                                        }),
                                                CustomCheckbox(
                                                    name: "Gravier",
                                                    value: context
                                                        .read<FilterFormCubit>()
                                                        .checkBoxPathGravel,
                                                    updateBoolean: (value) => {
                                                          context
                                                              .read<
                                                                  FilterFormCubit>()
                                                              .changePathGravel(
                                                                  value)
                                                        }),
                                                CustomCheckbox(
                                                    name: "Pavés",
                                                    value: context
                                                        .read<FilterFormCubit>()
                                                        .checkBoxPathPavingStones,
                                                    updateBoolean: (value) => {
                                                          context
                                                              .read<
                                                                  FilterFormCubit>()
                                                              .changePathPavingStones(
                                                                  value)
                                                        }),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomCheckbox(
                                                    name: "Route",
                                                    value: context
                                                        .read<FilterFormCubit>()
                                                        .checkBoxPathRoad,
                                                    updateBoolean: (value) => {
                                                          context
                                                              .read<
                                                                  FilterFormCubit>()
                                                              .changePathRoad(
                                                                  value)
                                                        }),
                                                CustomCheckbox(
                                                    name: "Piste Cyclable",
                                                    value: context
                                                        .read<FilterFormCubit>()
                                                        .checkBoxPathCyclePath,
                                                    updateBoolean: (value) => {
                                                          context
                                                              .read<
                                                                  FilterFormCubit>()
                                                              .changePathCyclePath(
                                                                  value)
                                                        }),
                                                CustomCheckbox(
                                                    name: "Autres",
                                                    value: context
                                                        .read<FilterFormCubit>()
                                                        .checkBoxPathOthers,
                                                    updateBoolean: (value) => {
                                                          context
                                                              .read<
                                                                  FilterFormCubit>()
                                                              .changePathOthers(
                                                                  value)
                                                        }),
                                              ],
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 20),
                                    const CustomCategoryTitle(
                                        name: "Type de vélo"),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomCheckbox(
                                                      name: "VTT",
                                                      value: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .checkBoxBikeAllTerrain,
                                                      updateBoolean: (value) =>
                                                          {
                                                            context
                                                                .read<
                                                                    FilterFormCubit>()
                                                                .changeBikeAllTerrain(
                                                                    value)
                                                          }),
                                                  CustomCheckbox(
                                                      name: "BMX",
                                                      value: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .checkBoxBikeBMX,
                                                      updateBoolean: (value) =>
                                                          {
                                                            context
                                                                .read<
                                                                    FilterFormCubit>()
                                                                .changeBikeBmx(
                                                                    value)
                                                          }),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomCheckbox(
                                                      name: "Ville",
                                                      value: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .checkBoxBikeCity,
                                                      updateBoolean: (value) =>
                                                          {
                                                            context
                                                                .read<
                                                                    FilterFormCubit>()
                                                                .changeBikeCity(
                                                                    value)
                                                          }),
                                                  CustomCheckbox(
                                                      name: "Gravier",
                                                      value: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .checkBoxBikeGravel,
                                                      updateBoolean: (value) =>
                                                          {
                                                            context
                                                                .read<
                                                                    FilterFormCubit>()
                                                                .changeBikeGravel(
                                                                    value)
                                                          }),
                                                ],
                                              ),
                                            ])),
                                    const SizedBox(height: 20),
                                    const CustomCategoryTitle(
                                        name: "Visibilité"),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomCheckbox(
                                                      name: "Privée",
                                                      value: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .checkBoxPrivate,
                                                      updateBoolean: (value) =>
                                                          {
                                                            context
                                                                .read<
                                                                    FilterFormCubit>()
                                                                .changeVisibilityPrivate(
                                                                    value)
                                                          }),
                                                  CustomCheckbox(
                                                      name: "Publique",
                                                      value: context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .checkBoxPublic,
                                                      updateBoolean: (value) =>
                                                          {
                                                            context
                                                                .read<
                                                                    FilterFormCubit>()
                                                                .changeVisibilityPublic(
                                                                    value)
                                                          }),
                                                ]),
                                          ],
                                        )),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: CustomColorScheme
                                                  .customSecondaryColor),
                                          onPressed: () => context
                                                  .read<FilterFormCubit>()
                                                  .isFormValid()
                                              ? {
                                                  context
                                                      .read<ListEventCubit>()
                                                      .filterEvents(context
                                                          .read<
                                                              FilterFormCubit>()
                                                          .getFilterDtos()),
                                                  Navigator.pop(context)
                                                }
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Problème de validation du formulaire"))),
                                          child: const Text('Confirmer'),
                                        )),
                                  ],
                                )))))));
      })
    ])));
  }
}
