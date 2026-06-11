import 'package:my_app_forge/features/home/data/models/home_model.dart';

abstract interface class HomeLocalDataSource {
  Future<void> cacheHomeItems(List<HomeModel> items);
  Future<List<HomeModel>> getCachedHomeItems();
  Future<void> clearCache();
}
