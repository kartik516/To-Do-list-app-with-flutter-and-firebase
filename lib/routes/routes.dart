import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_firebase_yt/feature/authentication/data/auth_repository.dart';
import 'package:todo_firebase_yt/routes/go_router_refresh_stream.dart';
import 'package:todo_firebase_yt/feature/authentication/presentation/screens/register_screen.dart';
import 'package:todo_firebase_yt/feature/authentication/presentation/screens/sign_in_screen.dart';
import 'package:todo_firebase_yt/feature/task_managment/presentation/screens/main_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart'; 

enum AppRoutes {
  main,
  signIn,
  register,
}

@riverpod 
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/signIn',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    redirect: (ctx, state) {
      final user = firebaseAuth.currentUser;
      final isLoggedIn = user != null;
      final loggingIn =
          state.uri.toString() == '/signIn' || state.uri.toString() == '/register';

      if (!isLoggedIn && state.uri.toString() == '/main') {
        return '/signIn';
      }
      if (isLoggedIn && loggingIn) {
        return '/main';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/main',
        name: AppRoutes.main.name,
        builder: (cxt, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        builder: (cxt, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        builder: (cxt, state) => const RegisterScreen(),
      ),
    ],
  );
}