import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final String name;
  TimeOfDay? time;

  CustomTimePicker({super.key, required this.name, required this.time});

  @override
  State<StatefulWidget> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      ElevatedButton(
          child: Text(widget.name, style: const TextStyle(color: Colors.black)),
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
                widget.time = time;
              });
            }
          }),
      const SizedBox(width: 20.0),
      if (widget.time != null)
        Text(FormatUtils.formatTimeOfDay(widget.time),
            style: const TextStyle(
              color: CustomColorScheme.customOnSecondary,
            )),
    ]);
  }
}
