class Link {
  final String url;
  final String quality;
  final String language;
  final bool isDownload;
  final bool include;

  const Link({
    required this.url,
    required this.quality,
    required this.language,
    required this.isDownload,
    required this.include,
  });

  String get hostname {
    final uri = Uri.parse(url);

    return uri.host == '' ? '${uri.scheme}.wtf' : uri.host;
  }

  Link copyWith({
    String? url,
    String? quality,
    String? language,
    bool? isDownload,
    bool? include,
  }) {
    return Link(
      url: url ?? this.url,
      quality: quality ?? this.quality,
      language: language ?? this.language,
      isDownload: isDownload ?? this.isDownload,
      include: include ?? this.include,
    );
  }
}
