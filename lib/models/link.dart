class Link {
  final String url;

  const Link({required this.url});

  String get hostname {
    final uri = Uri.parse(url);

    return uri.host == '' ? '${uri.scheme}.wtf' : uri.host;
  }

  Link copyWith({String? url}) {
    return Link(url: url ?? this.url);
  }
}
