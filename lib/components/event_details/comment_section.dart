import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/components/event_details/comment_card.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_state.dart';
import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final Event event;
  final DetailEventState state;

  const CommentSection({super.key, required this.event, required this.state});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _controller = TextEditingController();
  List<CommentDTO> comments = [];
  String username = "";
  var idComment = 0;


  @override
  void initState() {
    
    super.initState();
    for (var comment in widget.event.comments) {
      comments.add(comment);
    }
    _fetchUsername();
  }

  _fetchUsername() {
    var user = CopainsDeRouteApi().getLoggedUser();
    user.then((value) => {
          if (value.statusCode == 200) {username = value.data['login']}
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchUsername(),
      builder: (context, snapshot) {
        var commentWidgets = <Widget>[];
        for (var comment in comments) {
          CommentDTO commentdto = CommentDTO(
            id: comment.id,
            login: comment.login,
            content: comment.content,
            date: comment.date,
            likes: comment.likes,
          );
          commentWidgets.add(CommentCard(comment: commentdto));

        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                    controller: _controller,
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
                        onPressed: () async {
                        var data = await CopainsDeRouteApi().postComment(
                               _controller.text, username!, widget.event.id);
                       idComment = int.parse(data.data.toString());

                         CommentDTO comment = CommentDTO(
                            id: idComment,
                            login: username!,
                            content: _controller.text,
                            date: DateTime.now().toString(),
                            likes: 0,
                          );
                            comments.add(comment);
                            _controller.clear();
                            setState(
                                () {});
                          
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                for (var commentWidget in commentWidgets) commentWidget,
              ],
            ),
          ],
        );
      },
    );
  }
}