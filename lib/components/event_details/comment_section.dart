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
    comments.add(CommentCard());
    /*for (var comment in event.comments) {
      comments.add(CommentCard(comment));
    }*/

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Commentaires (event.comments.length)",
              style: TextStyle(
                  color: CustomColorScheme.customOnSecondary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Postez votre commentaire ...",
                      suffixIcon: Icon(Icons.send))),
            ),
            for (var comment in comments) comment,
          ],
        ),
      ],
    );
  }
}
