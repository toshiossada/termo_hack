import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../cache_adapter.dart';
import '../models/cache_model.dart';
import 'models/cache_model_database.dart';

class CacheHive implements ICacheAdapter {
  final completer = Completer<Box>();

  CacheHive() {
    _initDb();
  }
  Future _initDb() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocDirectory.path)
      ..registerAdapter(CacheModelDatabaseAdapter());

    final box = await Hive.openBox('cache');
    if (!completer.isCompleted) completer.complete(box);
  }

  @override
  Future<void> put(CacheModel data) async {
    final box = await completer.future;
    box.put(data.id, data.toMap());
  }

  @override
  Future<CacheModel?> get(String id) async {
    final box = await completer.future;
    final data = await box.get(id);

    if (data == null) return null;

    return CacheModel(
      id: data['id'],
      data: data['data'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    );
  }
}
