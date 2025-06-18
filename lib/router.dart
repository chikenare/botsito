import 'package:botsito/models/content.dart';
import 'package:botsito/pages/content/content_page.dart';
import 'package:botsito/pages/home/search_page.dart';
import 'package:botsito/pages/home/widgets/links_page.dart';
import 'package:botsito/pages/setting/setting_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SearchPage()),
    GoRoute(path: '/settings', builder: (context, state) => SettingPage()),
    GoRoute(
      path: '/contents',
      builder: (context, state) => ContentPage(content: state.extra as Content),
    ),
    GoRoute(
      path: '/links/:id',
      builder: (context, state) => LinksPage(id: state.pathParameters['id']!),
    ),
  ],
);
