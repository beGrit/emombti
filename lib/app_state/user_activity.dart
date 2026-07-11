import 'package:emombti/domain/models/activity/activity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_activity.freezed.dart';

@immutable
@freezed
abstract class UserActivityState with _$UserActivityState {
  const factory UserActivityState({@Default([]) List<Activity> items}) =
      _UserActivityState;

  const UserActivityState._();
}

class UserActivityNotifier extends ValueNotifier<UserActivityState> {
  UserActivityNotifier(super.value);

  void setActivities(List<Activity> activities) {
    value = value.copyWith(items: activities);
  }

  void addActivity(Activity activity) {
    value = value.copyWith(items: [...value.items, activity]);
  }

  void insertActivities(List<Activity> newActivities) {
    value = value.copyWith(items: [...value.items, ...newActivities]);
  }

  void removeActivity(String activityId) {
    value = value.copyWith(
      items: value.items.where((a) => a.id != activityId).toList(),
    );
  }

  void removeActivityByRelatedId(String relatedId) {
    value = value.copyWith(
      items: value.items.where((a) => a.relatedId != relatedId).toList(),
    );
  }
}
