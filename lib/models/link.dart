class Link {
  final String url;
  final String language;
  final bool isDownload;
  int? seasonNumber;
  int? episodeNumber;

  Link({
    required this.url,
    required this.language,
    required this.isDownload,
    this.seasonNumber,
    this.episodeNumber,
  });

  String get hostname {
    final uri = Uri.parse(url);

    return uri.host == '' ? '${uri.scheme}.wtf' : uri.host;
  }

  Link copyWith({
    String? url,
    String? language,
    bool? isDownload,
    int? seasonNumber,
    int? episodeNumber,
  }) {
    return Link(
      url: url ?? this.url,
      language: language ?? this.language,
      isDownload: isDownload ?? this.isDownload,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      episodeNumber: episodeNumber ?? this.episodeNumber,
    );
  }
}
