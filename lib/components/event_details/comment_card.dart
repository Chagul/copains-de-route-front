import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final CommentDTO comment;

  const CommentCard({super.key, required this.comment});

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
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 14,
                              color: CustomColorScheme.customOnSecondary),
                          children: [
                        TextSpan(
                            text: "${comment.login}, ",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "le ${comment.date}"),
                      ])),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 27),
                Text(
                  comment.content,
                  style: const TextStyle(
                      color: CustomColorScheme.customOnSecondary),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${comment.likes}",
                    style: const TextStyle(
                        color: CustomColorScheme.customError,
                        fontWeight: FontWeight.bold)),
                const Icon(
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
