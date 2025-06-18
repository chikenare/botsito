import 'dart:convert';

import 'package:botsito/models/setting/setting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_provider.g.dart';

const prefsSettingKey = 'setting';

@riverpod
class SettingP extends _$SettingP {
  @override
  Future<Setting?> build() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(prefsSettingKey);

    if (data == null) {
      return Setting(source: 'allcalidad.re', domains: []);
    }

    final json = jsonDecode(data);

    return Setting.fromJson(json);
  }

  Future<void> updateSetting(Setting setting) async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(setting.toJson());

    await prefs.setString(prefsSettingKey, data);

    state = AsyncValue.data(setting);
  }
}
