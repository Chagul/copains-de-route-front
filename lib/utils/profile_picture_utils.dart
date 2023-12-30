import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePictureUtils {
  static String? _getUrlProfilePicPromoterFromEvent(Event event) {
    if (event.promoterProfilePicLocation != null) {
      return CopainsDeRouteApi()
          .getUserProfilePicUrl(event.promoterProfilePicLocation!);
    }
    return null;
  }

  static String? _getUrlProfilePicPromoterFromUser(UserDTO user) {
    if (user.profilePicLocation != null) {
      return CopainsDeRouteApi().getUserProfilePicUrl(user.profilePicLocation!);
    }
    return null;
  }

  static Widget getEventPromoterProfilePicWidget(BuildContext context) {
    if (ProfilePictureUtils._getUrlProfilePicPromoterFromEvent(
            context.read<DetailEventCubit>().event) !=
        null) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
            ProfilePictureUtils._getUrlProfilePicPromoterFromEvent(
                context.read<DetailEventCubit>().event)!),
      );
    } else {
      return const Icon(Icons.person);
    }
  }

  static Widget getUserProfilePicWidget(BuildContext context) {
    if (ProfilePictureUtils._getUrlProfilePicPromoterFromUser(
            context.read<LoginCubit>().user) !=
        null) {
      return CircleAvatar(
          radius: 50,
          backgroundColor:
              CustomColorScheme.customPrimaryColor.withOpacity(0.5),
          child: CircleAvatar(
              radius: 47,
              backgroundImage: NetworkImage(
                  ProfilePictureUtils._getUrlProfilePicPromoterFromUser(
                      context.read<LoginCubit>().user)!)));
    } else {
      return const Icon(Icons.person);
    }
  }

  static Widget getFriendProfilePicWidget(FriendsDTO friend, String loginUser) {
    String? profilePicPathToDisplay = loginUser == friend.sender
        ? friend.addedProfilePicLocation
        : friend.senderProfilePicLocation;
    if (profilePicPathToDisplay != null) {
      return CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(CopainsDeRouteApi()
              .getUserProfilePicUrl(profilePicPathToDisplay)));
    } else {
      return const Icon(Icons.person);
    }
  }
}
