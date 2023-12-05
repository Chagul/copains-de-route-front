import 'package:copains_de_route/model/user_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class ParticipantsInfosListParticipants extends StatelessWidget {
  final List<UserDTO> participants;

  const ParticipantsInfosListParticipants(
      {super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: CustomColorScheme.customOnSecondary,
                      )),
                  const Text(
                    "Participants",
                    style: TextStyle(
                        color: CustomColorScheme.customOnSecondary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Card(
                  child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  return _buildRow(participants[index]);
                },
              ))
            ])));
  }

  Widget _buildRow(UserDTO participant) {
    return Row(
      children: [
        const Icon(
          Icons.person,
          color: CustomColorScheme.customOnSecondary,
        ),
        Text(
          participant.login,
          style: const TextStyle(
              color: CustomColorScheme.customOnSecondary, fontSize: 14),
        )
      ],
    );
  }
}
