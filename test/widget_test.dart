import 'package:flutter_test/flutter_test.dart';
import 'package:my_app_forge/core/error/failures.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';

void main() {
  group('HomeEntity Tests', () {
    test('supports value equality via Equatable', () {
      final now = DateTime.now();
      final entity1 = HomeEntity(
        id: '1',
        title: 'Title',
        description: 'Description',
        createdAt: now,
        isBookmarked: false,
      );

      final entity2 = HomeEntity(
        id: '1',
        title: 'Title',
        description: 'Description',
        createdAt: now,
        isBookmarked: false,
      );

      expect(entity1, equals(entity2));
    });
  });

  group('Failure Tests', () {
    test('ServerFailure returns correct userMessage', () {
      const failure = ServerFailure(500, 'Internal Server Error');
      expect(failure.userMessage, contains('Server error occurred (500).'));
    });

    test('NetworkFailure returns correct userMessage', () {
      const failure = NetworkFailure();
      expect(failure.userMessage, contains('check your internet connection'));
    });
  });
}
