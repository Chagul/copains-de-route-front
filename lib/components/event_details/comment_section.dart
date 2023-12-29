import 'package:copains_de_route/components/event_details/comment_card.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_state.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentSection extends StatelessWidget {
  final Event event;

  const CommentSection({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailEventCubit(event: event),
      child: CommentSectionContent(event: event),
    );
  }
}

class CommentSectionContent extends StatelessWidget {
  final Event event;

  const CommentSectionContent({Key? key, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = "";
    username = context.read<LoginCubit>().user.login;
    var controller = TextEditingController();
    int idComment = 0;

    return BlocBuilder<DetailEventCubit, DetailEventState>(
      builder: (context, state) {
        if (state is CommentUsernameFetchedState) {
          username = state.username;
        } else if (state is DetailEventCommentPostedState) {
          idComment = state.idComment;
          context.read<DetailEventCubit>().addCommentToEvent(
                idComment,
                state.comment,
                username,
              );
        }

        return _buildCommentSection(
            context, event.comments, username, controller);
      },
    );
  }

  Widget _buildCommentSection(BuildContext context, List<CommentDTO> comments,
      String username, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Commentaires (${comments.length})",
          style: const TextStyle(
            color: CustomColorScheme.customOnSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.90,
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: CustomColorScheme.customOnSecondary,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Postez votre commentaire ...",
              labelStyle: const TextStyle(
                color: CustomColorScheme.customOnSecondary,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: CustomColorScheme.customOnSecondary,
                ),
                onPressed: () {
                  context.read<DetailEventCubit>().postComment(
                        controller.text,
                        username,
                        event.id,
                      );
                  controller.clear();
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        for (var commentWidget
            in comments.map((comment) => CommentCard(comment: comment)))
          commentWidget,
      ],
    );
  }
}
