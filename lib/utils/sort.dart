import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/format_utils.dart';

class SortUtils {
  (bool, EventList) sortByParticipants(
      EventList dataDisplayed, bool sortedByParticipants) {
    if (sortedByParticipants) {
      dataDisplayed.eventList.sort(
          (a, b) => b.participants.length.compareTo(a.participants.length));
      sortedByParticipants = false;
    } else {
      dataDisplayed.eventList.sort(
          (a, b) => a.participants.length.compareTo(b.participants.length));
      sortedByParticipants = true;
    }

    return (sortedByParticipants, dataDisplayed);
  }

  (bool, EventList) sortByDistance(
      EventList dataDisplayed, bool sortedByDistance) {
    if (sortedByDistance) {
      dataDisplayed.eventList.sort((a, b) => b.distance.compareTo(a.distance));
      sortedByDistance = false;
    } else {
      dataDisplayed.eventList.sort((a, b) => a.distance.compareTo(b.distance));
      sortedByDistance = true;
    }

    return (sortedByDistance, dataDisplayed);
  }

  (bool, EventList) sortByDate(EventList dataDisplayed, bool sortedByDate) {
    if (sortedByDate) {
      dataDisplayed.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(b.startDate, b.startTime))
              .compareTo(FormatUtils.formatDateTime(a.startDate, a.startTime)));
      sortedByDate = false;
    } else {
      dataDisplayed.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(a.startDate, a.startTime))
              .compareTo(FormatUtils.formatDateTime(b.startDate, b.startTime)));
      sortedByDate = true;
    }

    return (sortedByDate, dataDisplayed);
  }
}
