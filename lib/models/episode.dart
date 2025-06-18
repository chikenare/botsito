class Episode {
  final String id;
  final int seasonNumber;
  final int episodeNumber;

  const Episode({
    required this.id,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  String getVid() =>
      'S${seasonNumber < 10 ? '0$seasonNumber' : seasonNumber}E${episodeNumber < 10 ? '0$episodeNumber' : episodeNumber}';
}
