import 'package:crud_user/views/home_screen.dart';
import 'package:crud_user/views/service/add_users.dart';
import 'package:crud_user/views/service/maintenance_users.dart';
import 'package:go_router/go_router.dart';

//GoRouter Configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add',
      name: AddUsers.name,
      builder: (context, state) => const AddUsers(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const ListUsers(),
    ),
  ]
);