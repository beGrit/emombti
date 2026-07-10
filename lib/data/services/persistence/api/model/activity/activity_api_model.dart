import 'package:emombti/utils/converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_api_model.freezed.dart';
part 'activity_api_model.g.dart';

@freezed
abstract class ActivityApiModel with _$ActivityApiModel {
  const factory ActivityApiModel({
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    String? title,
    String? description,
    String? relatedId,
    @Default('post') String type,
    String? thumbnailUrl,
    @FirestoreTimestampConverter() required DateTime createdAt,
  }) = _ActivityApiModel;

  factory ActivityApiModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityApiModelFromJson(json);
}
