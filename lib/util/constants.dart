import 'package:botsito/models/source.dart';

final domainRegex = RegExp(
  r'^(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$',
);

final sources = [
  Source(name: 'Pelisplushd', domains: ['pelisplushd.me']),
  Source(name: 'Full', domains: ['embed69']),
  Source(name: 'La.movie', domains: ['la.movie']),
  Source(name: 'Cuevana', domains: ['cuevana.biz']),
  Source(name: 'Pocketapp', domains: []),
  Source(name: 'Allcalidad', domains: ['allcalidad.re']),
  Source(name: 'Cinecalidad', domains: ['cinecalidad.ec']),
  Source(name: 'Pelisforte', domains: ['www2.pelisforte.se']),
];

final defaultProvider = sources.first.name;
