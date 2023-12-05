import 'package:copains_de_route/components/event_details/participants_infos_list_participants.dart';
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
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Participants",
                        style: TextStyle(
                            color: CustomColorScheme.customOnSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons
                            .person /*event.participants.firstUser.profilePic*/),
                        const Icon(Icons
                            .person /*event.participants.secondUser.profilePic*/),
                        const Icon(Icons
                            .person /*event.participants.thirdUser.profilePic*/),
                        const SizedBox(width: 5),
                        Text(
                          "+ ${event.participants.length - 3} autres",
                          style: const TextStyle(
                              color: CustomColorScheme.customOnSecondary),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ParticipantsInfosListParticipants(
                                            participants: event.participants))),
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: CustomColorScheme.customOnSecondary,
                            ))
                      ],
                    )
                  ],
                )))
      ],
    );
  }
}
