import 'package:copains_de_route/model/user_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';

class ParticipantsInfosListParticipants extends StatelessWidget {
  final List<UserDTO> participants;

  const ParticipantsInfosListParticipants(
      {super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(context),
                              icon: const Icon(Icons.arrow_back,
                                  color: CustomColorScheme.customOnSurface)),
                          const Text("Participants",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColorScheme.customOnSurface))
                        ],
                      ),
                      if (participants.isEmpty)
                        const Text("Aucun participant pour le moment")
                      else
                        Expanded(
                          child: Card(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: participants.length,
                              itemBuilder: (context, index) {
                                return _buildRow(participants[index]);
                              },
                            ),
                          ),
                        )
                    ]))));
  }

  Widget _buildRow(UserDTO participant) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          ProfilePictureUtils.getParticipantProfilPicWidget(participant),
          const SizedBox(width: 10),
          Text(
            participant.login,
            style: const TextStyle(
                color: CustomColorScheme.customOnSecondary, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
