import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  const HomeEntity({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.createdAt,
    required this.isBookmarked,
  });

  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isBookmarked;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        createdAt,
        isBookmarked,
      ];
}
