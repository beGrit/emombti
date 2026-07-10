import 'package:emombti/data/repositories/activity/activity_repository.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/activity/activity_api_model.dart';
import 'package:emombti/domain/models/activity/activity.dart';
import 'package:emombti/utils/result.dart';

class ActivityRepositoryFirestore implements ActivityRepository {
  ActivityRepositoryFirestore({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  @override
  Future<Result<List<Activity>>> getActivities(String userId) async {
    try {
      final apiModels = await _firestoreService.getUserActivities(userId);
      final activities = apiModels.map(_mapActivityApiModelToDomain).toList();
      return Result.ok(activities);
    } catch (e) {
      return Result.error(Exception('Failed to load activities.'));
    }
  }

  Activity _mapActivityApiModelToDomain(ActivityApiModel apiModel) {
    return Activity(
      id: apiModel.id ?? '',
      title: apiModel.title,
      relatedId: apiModel.relatedId,
      description: apiModel.description,
      type: _mapActivityType(apiModel.type),
      thumbnailUrl: apiModel.thumbnailUrl,
      createdAt: apiModel.createdAt,
    );
  }

  ActivityType _mapActivityType(String type) {
    return ActivityType.values.firstWhere(
      (value) => value.name == type,
      orElse: () => ActivityType.post,
    );
  }

  @override
  Future<Result<Activity>> saveActivity(
    String userId,
    Activity activity,
  ) async {
    try {
      final id = (activity.id.isNotEmpty)
          ? activity.id
          : _firestoreService.generateFirestoreId();

      final apiModel = ActivityApiModel(
        id: id,
        title: activity.title,
        description: activity.description,
        relatedId: activity.relatedId,
        type: activity.type.name,
        thumbnailUrl: activity.thumbnailUrl,
        createdAt: activity.createdAt,
      );

      await _firestoreService.saveUserActivity(userId, apiModel);

      return Result.ok(activity.copyWith(id: id));
    } catch (e) {
      return Result.error(Exception('Failed to save activity.'));
    }
  }

  @override
  Future<Result<List<Activity>>> getActivitiesLimit(
    String userId,
    int limit, {
    String? lastActivityId,
  }) async {
    try {
      final apiModels = await _firestoreService.getUserActivitiesLimit(
        userId,
        limit: limit,
        lastActivityId: lastActivityId,
      );

      final activities = apiModels.map(_mapActivityApiModelToDomain).toList();
      return Result.ok(activities);
    } catch (e) {
      return Result.error(Exception('Failed to load paginated activities.'));
    }
  }

  @override
  Future<Result<void>> deleteActivity(String userId, String activityId) async {
    try {
      await _firestoreService.deleteActivity(userId, activityId);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to delete activity.'));
    }
  }

  @override
  Future<Result<void>> deleteByRelatedId(
    String userId,
    ActivityType activityType,
    String relatedId,
  ) async {
    try {
      await _firestoreService.deleteActivityByRelatedId(
        userId,
        activityType.name,
        relatedId,
      );
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
