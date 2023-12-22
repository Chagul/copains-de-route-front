import 'package:copains_de_route/components/event_details/comment_card.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final Event event;

  const CommentSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var comments = <Widget>[];
    for (var comment in event.comments) {
      comments.add(CommentCard(
        comment: comment,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Commentaires (${event.comments.length})",
              style: const TextStyle(
                  color: CustomColorScheme.customOnSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                  style: TextStyle(color: CustomColorScheme.customOnSecondary),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Postez votre commentaire ...",
                      labelStyle:
                          TextStyle(color: CustomColorScheme.customOnSecondary),
                      suffixIcon: Icon(
                        Icons.send,
                        color: CustomColorScheme.customOnSecondary,
                      ))),
            ),
            const SizedBox(height: 10),
            for (var comment in comments) comment,
          ],
        ),
      ],
    );
  }
}
