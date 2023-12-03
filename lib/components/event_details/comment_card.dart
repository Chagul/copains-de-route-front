import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  // final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person),
                SizedBox(
                  height: 15,
                  child: RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 14,
                              color: CustomColorScheme.customOnSecondary),
                          children: [
                        TextSpan(
                            text: "comment.user.login, ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "le comment.date à comment.time"),
                      ])),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 27),
                Text(
                  "comment.text",
                  style: TextStyle(color: CustomColorScheme.customOnSecondary),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("comment.likes",
                    style: TextStyle(
                        color: CustomColorScheme.customError,
                        fontWeight: FontWeight.bold)),
                Icon(
                  Icons.favorite,
                  color: CustomColorScheme.customError,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
