import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/feed_view.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';

/// Notificador que escucha cambios en el Stream de autenticación de Firebase
/// para refrescar automáticamente el estado de GoRouter.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final String location = state.matchedLocation;
      final bool isLoggingIn = location == '/login';
      final bool isRegistering = location == '/registro';

      // Si no hay sesión iniciada, solo se puede acceder al login y al registro
      if (!loggedIn) {
        if (!isLoggingIn && !isRegistering) {
          return '/login';
        }
        return null;
      }

      // Si hay sesión iniciada, se debe ir al feed
      if (isLoggingIn || isRegistering) {
        return '/feed';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/registro',
        name: 'registro',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/feed',
        name: 'feed',
        builder: (context, state) => const FeedView(),
      ),
    ],
  );
}
