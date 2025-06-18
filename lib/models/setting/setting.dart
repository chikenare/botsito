import 'package:botsito/models/setting/domain.dart';

class Setting {
  final String source;
  final List<Domain> domains;

  const Setting({required this.source, required this.domains});

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    source: json['source'],
    domains: List<Domain>.from(json['domains'].map((e) => Domain.fromJson(e))),
  );

  Map<String, dynamic> toJson() => {
    'source': source,
    'domains': domains.map((e) => e.toJson()).toList(),
  };
}
