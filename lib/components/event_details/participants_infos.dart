import 'package:copains_de_route/components/event_details/participants_infos_list_participants.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
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
                        if (event.participants.isNotEmpty)
                          ProfilePictureUtils.getParticipantProfilPicWidget(
                              event.participants[0]),
                        if (event.participants.length > 1)
                          ProfilePictureUtils.getParticipantProfilPicWidget(
                              event.participants[1]),
                        if (event.participants.length > 2)
                          ProfilePictureUtils.getParticipantProfilPicWidget(
                              event.participants[2]),
                        const SizedBox(width: 5),
                        Text(
                          " ${event.participants.length} participant(s)",
                          style: const TextStyle(
                              color: CustomColorScheme.customOnSecondary),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).push(
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
