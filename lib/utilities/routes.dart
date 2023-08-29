import 'package:air_quality_index/pages/home/home_page.dart';
import 'package:go_router/go_router.dart';

final defaultRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
