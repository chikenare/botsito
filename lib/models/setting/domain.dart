class Domain {
  final String id;
  final String name;
  final String hostname;
  final bool ignore;
  final List<String> childDomains;

  const Domain({
    required this.id,
    required this.name,
    required this.hostname,
    required this.ignore,
    required this.childDomains,
  });

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    id: json['id'],
    name: json['name'],
    hostname: json['hostname'],
    ignore: json['ignore'],
    childDomains: List<String>.from(
      json['childDomains'].map((e) => e.toString()),
    ),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'hostname': hostname,
    'ignore': ignore,
    'childDomains': childDomains,
  };
}
