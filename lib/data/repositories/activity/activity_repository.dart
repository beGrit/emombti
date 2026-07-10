import 'package:emombti/domain/models/activity/activity.dart';
import 'package:emombti/utils/result.dart';

abstract class ActivityRepository {
  Future<Result<List<Activity>>> getActivities(String userId);
  Future<Result<Activity>> saveActivity(String userId, Activity activity);
  Future<Result<void>> deleteActivity(String userId, String activityId);
  Future<Result<List<Activity>>> getActivitiesLimit(
    String userId,
    int limit, {
    String? lastActivityId,
  });
  Future<Result<void>> deleteByRelatedId(
    String userId,
    ActivityType activityType,
    String relatedId,
  );
}

