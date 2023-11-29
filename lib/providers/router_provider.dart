import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/home_screen.dart';
import '../ui/login_screen.dart';
import 'login_controller_provider.dart';

List<GoRoute> get _routes => [
      GoRoute(
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        path: '/login',
      ),
      GoRoute(
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        path: '/',
      ),
    ];

final routerProvider = Provider<GoRouter>((ref) {
  // final router = RouterNotifier(ref);
  final isAuthed = ref.watch(loginControllerProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: isAuthed,
    redirect: (context, state) {
      final areWeLoggingIn = isAuthed.isLoggedIn;

      if (state.fullPath == '/login') {
        return areWeLoggingIn ? null : '/login';
      }

      return areWeLoggingIn ? '/' : '/login';
    },
    routes: _routes,
  );
});

// class RouterNotifier extends ChangeNotifier {
//   final Ref _ref;

//   RouterNotifier(this._ref) {
//     _ref.listen<LoginState>(
//       loginControllerProvider,
//       (_, __) => notifyListeners(),
//     );
//   }

//   String? _redirectLogic(BuildContext context, GoRouterState state) {
//     // final loginState = _ref.read(loginControllerProvider);

//     // final areWeLoggingIn = state.uri.toString() == '/login';

//     // if (loginState is LoginStateInitial) {
//     //   return areWeLoggingIn ? null : '/login';
//     // }

//     // if (areWeLoggingIn) return '/';

//     return '/';
//   }

  // List<GoRoute> get _routes => [
  //       GoRoute(
  //         name: 'login',
  //         builder: (context, state) => const LoginScreen(),
  //         path: '/login',
  //       ),
  //       GoRoute(
  //         name: 'home',
  //         builder: (context, state) => const HomeScreen(),
  //         path: '/',
  //       ),
  //     ];
// }
