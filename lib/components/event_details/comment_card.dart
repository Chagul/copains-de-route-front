import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final CommentDTO comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLiked = false;
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
                            text: "${widget.comment.login}, ",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "le ${widget.comment.date}"),
                      ])),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 27),
                Text(
                  widget.comment.content,
                  style: const TextStyle(
                      color: CustomColorScheme.customOnSecondary),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${widget.comment.likes}",
                    style: const TextStyle(
                        color: CustomColorScheme.customError,
                        fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked
                        ? CustomColorScheme.customError
                        : CustomColorScheme.customOnSecondary,
                  ),
                  onPressed: () async {
                    if (!isLiked) {
                      setState(() {
                        isLiked = true;
                      });
                      int likedCommentId = widget.comment.id ?? 0;
                      await CopainsDeRouteApi().likeComment(likedCommentId);
                      widget.comment.likes++;
                      setState(() {});
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
