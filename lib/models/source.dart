class Source {
  final String name;
  final List<String> domains;

  const Source({required this.name, required this.domains});

  String get icon =>
      'https://www.google.com/s2/favicons?domain=${domains.first}&sz=100';
}
