import 'package:botsito/models/content.dart';
import 'package:botsito/pages/content/content_page.dart';
import 'package:botsito/pages/home/search_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SearchPage()),
    GoRoute(
      path: '/contents',
      builder: (context, state) => ContentPage(content: state.extra as Content),
    ),
  ],
);
