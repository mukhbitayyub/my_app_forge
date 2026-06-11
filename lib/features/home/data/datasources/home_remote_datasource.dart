import 'package:my_app_forge/features/home/data/models/home_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<HomeModel>> getHomeItems({int? page, int? limit});
  Future<HomeModel> getHomeItemById(String id);
  Future<void> bookmarkItem(String id);
  Future<void> removeBookmark(String id);
}
