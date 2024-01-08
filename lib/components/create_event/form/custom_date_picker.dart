import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatefulWidget {
  final String name;
  TextEditingController input;

  CustomDatePicker({super.key, required this.name, required this.input});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.name,
            style: const TextStyle(color: CustomColorScheme.customOnSurface)),
        SizedBox(
          width: 140,
          child: TextField(
            controller: widget.input,
            decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                icon: Icon(Icons.calendar_today,
                    color: CustomColorScheme.customOnSecondary)),
            style: const TextStyle(color: CustomColorScheme.customOnSecondary),
            readOnly: true,
            onTap: () async {
              DateTime? eventDate = await showDatePicker(
                  context: context,
                  locale: const Locale("fr", "FR"),
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.yellow,
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
                  widget.input.text = formattedDate;
                });
              }
            },
          ),
        )
      ],
    );
  }
}
