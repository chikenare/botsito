import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  static Completer<Isar>? _completer;

  IsarService._internal();

  factory IsarService() => _instance;

  Future<Isar> getInstance() async {
    if (_completer != null) return _completer!.future;

    _completer = Completer();
    try {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open([], directory: dir.path);
      _completer!.complete(isar);
    } catch (e) {
      _completer!.completeError(e);
      _completer = null;
      rethrow;
    }

    return _completer!.future;
  }
}
