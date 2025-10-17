import 'package:botsito/models/source.dart';

final domainRegex = RegExp(
  r'^(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$',
);


final sources = [
  Source(
    name: 'Allcalidad',
    domains: ['allcalidad.re'],
    icon: 'allcalidad.png',
  ),
  Source(
    name: 'Cinecalidad',
    domains: ['cinecalidad.ec'],
    icon: 'cinecalidad.png',
  ),
];
