import 'package:json_annotation/json_annotation.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';

part 'home_model.g.dart';

@JsonSerializable(createFactory: false)
class HomeModel extends HomeEntity {
  const HomeModel({
    required super.id,
    required super.title,
    required super.description,
    super.imageUrl,
    required super.createdAt,
    required super.isBookmarked,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
    );
  }

  factory HomeModel.fromEntity(HomeEntity entity) {
    return HomeModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
      isBookmarked: entity.isBookmarked,
    );
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
