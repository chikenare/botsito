class Setting {
  final String source;
  final bool forceInclude;

  const Setting({required this.source, required this.forceInclude});

  factory Setting.fromJson(Map<String, dynamic> json) =>
      Setting(source: json['source'], forceInclude: json['forceInclude']);

  Map<String, dynamic> toJson() => {
    'source': source,
    'forceInclude': forceInclude,
  };

  Setting copyWith({String? source, bool? forceInclude}) => Setting(
    source: source ?? this.source,
    forceInclude: forceInclude ?? this.forceInclude,
  );
}
