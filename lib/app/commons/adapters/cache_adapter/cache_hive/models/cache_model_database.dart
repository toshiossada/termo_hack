// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:hive/hive.dart';

import '../../models/cache_model.dart';

part 'cache_model_database.g.dart';

@HiveType(typeId: 1)
class CacheModelDatabase extends HiveObject implements CacheModel {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final DateTime date;

  @HiveField(2)
  @override
  final Map<String, dynamic> data;

  CacheModelDatabase({
    required this.id,
    required this.data,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'data': data,
    };
  }

  @override
  String toJson() => json.encode(toMap());
}
