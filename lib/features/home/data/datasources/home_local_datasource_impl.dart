import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/storage/local_datasource.dart';
import 'package:my_app_forge/core/storage/storage_keys.dart';
import 'package:my_app_forge/features/home/data/datasources/home_local_datasource.dart';
import 'package:my_app_forge/features/home/data/models/home_model.dart';

@LazySingleton(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl(this._localDataSource);

  final LocalDataSource _localDataSource;

  @override
  Future<void> cacheHomeItems(List<HomeModel> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await _localDataSource.saveString(StorageKeys.homeCache, encoded);
  }

  @override
  Future<List<HomeModel>> getCachedHomeItems() async {
    try {
      final jsonStr = await _localDataSource.getString(StorageKeys.homeCache);
      if (jsonStr == null || jsonStr.isEmpty) {
        return [];
      }
      final decoded = jsonDecode(jsonStr) as List<dynamic>;
      return decoded
          .map((item) => HomeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Object catch (_) {
      return [];
    }
  }

  @override
  Future<void> clearCache() async {
    await _localDataSource.remove(StorageKeys.homeCache);
  }
}
