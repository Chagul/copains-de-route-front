import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class ParticipantsInfos extends StatelessWidget {
  final Event event;

  const ParticipantsInfos({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
            child: SizedBox(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Participants",
                style: TextStyle(
                    color: CustomColorScheme.customOnSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person /*event.participants.firstUser.profilePic*/),
                Icon(Icons.person /*event.participants.secondUser.profilePic*/),
                Icon(Icons.person /*event.participants.thirdUser.profilePic*/),
                Text(
                  "+ event.name.participants-3 autres",
                  style: TextStyle(color: CustomColorScheme.customOnSecondary),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => print("Liste participants"),
                    icon: const Icon(Icons.arrow_circle_right_outlined))
              ],
            )
          ],
        )))
      ],
    );
  }
}
