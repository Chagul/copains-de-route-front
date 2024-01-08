import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CommentCard extends StatefulWidget {
  final CommentDTO comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  CommentCardState createState() => CommentCardState();
}

class CommentCardState extends State<CommentCard> {
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
                        TextSpan(
                            text:
                                "le ${DateFormat("dd/MM/yyyy hh:mm").format(DateTime.parse(widget.comment.date))}"),
                      ])),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          widget.comment.content,
                          style: const TextStyle(
                              color: CustomColorScheme.customOnSecondary),
                        )))
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
                  icon: const Icon(Icons.favorite,
                      color: CustomColorScheme.customError),
                  onPressed: () {
                    isLiked = widget.comment.isLiked ?? false;
                    int likedCommentId = widget.comment.id!;
                    if (!isLiked) {
                      context
                          .read<DetailEventCubit>()
                          .likeComment(likedCommentId, widget.comment.likes);
                    } else {
                      context
                          .read<DetailEventCubit>()
                          .dislikeComment(likedCommentId, widget.comment.likes);
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
