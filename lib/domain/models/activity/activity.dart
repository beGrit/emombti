import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

enum ActivityType { post, video, popular }

@freezed
abstract class Activity with _$Activity {
  const factory Activity({
    required String id,
    String? title,
    String? description,
    String? relatedId,
    required ActivityType type,
    String? thumbnailUrl,
    required DateTime createdAt,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
