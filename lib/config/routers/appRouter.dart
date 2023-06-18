import 'package:google_mao/features/auth/presentacion/screens/home_screems.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mao/features/auth/presentacion/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
    path: '/login',
    name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/home',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
]);
