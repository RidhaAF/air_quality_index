import 'package:air_quality_index/pages/aqi_guide/aqi_guide_page.dart';
import 'package:air_quality_index/pages/home/home_page.dart';
import 'package:air_quality_index/pages/search/search_page.dart';
import 'package:go_router/go_router.dart';

final defaultRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'aqi-guide',
      path: '/aqi-guide',
      builder: (context, state) => const AqiGuidePage(),
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
  ],
);
