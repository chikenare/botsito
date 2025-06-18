class Domain {
  final String id;
  final String name;
  final bool ignore;
  final List<String> replaceBy;

  const Domain({
    required this.id,
    required this.name,
    required this.ignore,
    required this.replaceBy,
  });

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    id: json['id'],
    name: json['name'],
    ignore: json['ignore'],
    replaceBy: List<String>.from(json['replaceBy'].map((e) => e.toString())),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'ignore': ignore,
    'replaceBy': replaceBy,
  };
}
