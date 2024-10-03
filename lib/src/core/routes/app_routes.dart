import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/sign_up_form_widget.dart';
import '../../features/auth/presentation/views/user_list.dart';
import '../../pkg.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return _router(ref);
});

GoRouter _router(Ref ref) {
  // final authState = ref.watch(authProvider);
  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: Routes.splashPath,
    redirectLimit: 100,
    routes: [
      GoRoute(
        path: Routes.homePath,
        name: Routes.home,
        builder: (context, state) {
          print(state.extra);
          print('state====');
          // print(state.name);
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: Routes.splashPath,
        name: Routes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
        // redirect: (context, state) async {
        //   await Future.delayed(Duration(seconds: 1));
        //   return '/user';
        // }
      ),
      GoRoute(
        path: Routes.loginPath,
        name: Routes.login,
        builder: (context, state) {
          print(state.extra);
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.signUpPath,
        name: Routes.signUp,
        builder: (context, state) {
          print(state.extra);
          return const SignUpFormWidget();
        },
      ),
      GoRoute(
        path: Routes.userPath,
        name: Routes.user,
        builder: (context, state) {
          return const UserList();
        },
      ),
    ],
    redirect: (context, GoRouterState state) async {
      printLog("state.name");
      final splashLocation = state.namedLocation(Routes.splash);
      printLog(state.fullPath);
      if (splashLocation == Routes.splashPath) {
        // await Future.delayed(Duration(seconds: 1));
        printLog("state.name $splashLocation");
        // return Routes.userPath;
      }
      // If our async state is loading, don't perform redirects, yet
      // if (authState.isLoading || authState.hasError) return null;
      //
      // // Here we guarantee that hasData == true, i.e. we have a readable value
      //
      // // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // // Returning `null` means "we are not authorized"
      // final isAuth = authState.valueOrNull != null;
      //
      // final isSplash = state.location == SplashPage.routeLocation;
      // if (isSplash) {
      //   return isAuth ? HomePage.routeLocation : LoginPage.routeLocation;
      // }
      //
      // final isLoggingIn = state.location == LoginPage.routeLocation;
      // if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;
      //
      // return isAuth ? null : SplashPage.routeLocation;
      logger.d(state.matchedLocation);
      final bool loggingIn = state.matchedLocation == Routes.splashPath;
      printLog('go router ing ::: $loggingIn');
      //   if(loggingIn){
      //      Timer(const Duration(seconds: 3), () {
      //     // GoRouter.of(context).go('/home');
      //     });
      //  return Routes.homePath;
      //   }

      return null;
    },
  );
}
// final navigatorKey = GlobalKey<NavigatorState>();

// String _initialLocation = '/';

// final _router = GoRouter(
//   initialLocation: '/splash',
//   navigatorKey: navigatorKey,
//   // observers: [SentryNavigatorObserver()],
//   redirect: _redirect,
//   routes: [
//     GoRoute(
//       name: 'splash', // Optional, add name to your routes. Allows you navigate by name instead of path
//       path: '/splash',
//       builder: (context, state) => const SplashScreen(),
//     ),
//     // GoRoute(
//     //   name: 'login',
//     //   path: '/login',
//     //   builder: (context, state) =>
//     //       LoginScreen(redirect: state.uri.queryParameters['redirect']),
//     // ),
//     // GoRoute(
//     //   name: 'verify',
//     //   path: '/verify',
//     //   builder: (context, state) =>
//     //       VerifyScreen(redirect: state.uri.queryParameters['redirect']),
//     // ),
//     // GoRoute(
//     //   name: 'profile-edit',
//     //   path: '/profile',
//     //   builder: (context, state) =>
//     //       ProfileFormScreen(redirect: state.uri.queryParameters['redirect']),
//     // ),
//     // GoRoute(
//     //   name: 'profile-view',
//     //   path: '/profiles/:id',
//     //   builder: (context, state) =>
//     //       ProfileScreen(userId: state.pathParameters['id']!),
//     // ),
//     // GoRoute(
//     //   name: 'home',
//     //   path: '/',
//     //   builder: (context, state) => const HomeScreen(),
//     // ),
//     // GoRoute(
//     //   name: 'settings',
//     //   path: '/settings',
//     //   builder: (context, state) => const SettingsScreen(),
//     // ),
//     // GoRoute(
//     //   name: 'post-event',
//     //   path: '/post-event',
//     //   builder: (context, state) => EventEditScreen(
//     //       facebookUrl: state.uri.queryParameters['facebookUrl'],
//     //       duplicateEventId: state.uri.queryParameters['duplicateEventId']),
//     // ),
//     // GoRoute(
//     //   name: 'event-details',
//     //   path: '/events/:id',
//     //   builder: (context, GoRouterState state) =>
//     //       EventDetailsScreen(instanceId: state.pathParameters['id']!),
//     // ),
//     // GoRoute(
//     //   name: 'event-edit',
//     //   path: '/events/:id/edit',
//     //   builder: (context, GoRouterState state) =>
//     //       EventEditScreen(instanceId: state.pathParameters['id']!),
//     // ),
//     // GoRoute(
//     //   name: 'friends',
//     //   path: '/friends',
//     //   builder: (context, state) => const FriendsScreen(),
//     // ),
//     // GoRoute(
//     //   name: 'map',
//     //   path: '/map',
//     //   builder: (context, state) => const MapScreen(),
//     // ),
//     // GoRoute(
//     //   name: 'topics',
//     //   path: '/topics',
//     //   builder: (context, state) => const TopicsScreen(),
//     // ),
//   ],
// );

// ProviderRef? _ref;
// final routerProvider = Provider((ref) {
//   _ref = ref;
//   return _router;
// });

// Future<String?> _redirect(BuildContext context, GoRouterState state) async {
//   // final splashComplete = _ref!.read(splashCompleteProvider);
//   // final session = _ref!.read(authControllerProvider);

//   // continue if route is login, verify or splash
//   if (state.topRoute?.name == 'login' ||
//       state.topRoute?.name == 'verify' ||
//       state.topRoute?.name == 'splash') {
//     return null;
//   }

//   // save to initial route and return existing location if splash isn't finished
//   // if (!splashComplete) {
//   //   _initialLocation = state.uri.toString();
//   //   final currentLocation = _router.routerDelegate.currentConfiguration.isEmpty
//   //       ? '/splash'
//   //       : _router.routerDelegate.currentConfiguration.last.matchedLocation;
//   //   logger.d({
//   //     'splash not complete, saving redirect to initialLocation': {
//   //       'initialLocation': state.uri.toString(),
//   //       'curretLocation': currentLocation,
//   //     }
//   //   });
//   //   return currentLocation;
//   // }

//   logger.d('processing redirect to ${state.uri.toString()}');

//   // continue if user is authenticated
//   // if (session != null) {
//   //   return null;
//   // }

//   // continue unauthenticated if on a public event details screen
//   // if (state.topRoute?.name == 'event-details' &&
//   //     state.pathParameters['id'] != null) {
//   //   await supabaseInitialized;
//   //   try {
//   //     final event = await _ref!
//   //         .read(eventDetailsProvider(state.pathParameters['id']!).future);

//   //     // allow unauthenticated access to public events
//   //     if (event.visibility == InstanceVisibility.public) {
//   //       return null;
//   //     }
//   //   } catch (error) {
//   //     logger.e('error fetching event details', error: error);
//   //   }
//   // }

//   // otherwise: redirect to login screen
//   final redirect = state.uri.toString();
//   return state.namedLocation('login',
//       queryParameters: redirect == '/'
//           ? {}
//           : {
//               'redirect': redirect,
//             });
// }

// void goInitialLocation([String? overrideLocation]) async {
//   final String initialLocation = overrideLocation ?? _initialLocation;
//   final currentRouteName =
//       _router.routerDelegate.currentConfiguration.last.route.name;

//   logger.t({
//     'goInitialLocation': {
//       'initialLocation': initialLocation,
//       'currentRouteName': currentRouteName,
//     }
//   });

//   // send user to profile screen if profile is not set
//   // final session = _ref!.read(authControllerProvider);
//   // if (session != null) {
//   //   try {
//   //     final profile = await _ref!.read(profileProvider.future);
//   //     if (profile == null) {
//   //       _router.goNamed('profile-edit',
//   //           queryParameters:
//   //               overrideLocation == null ? {} : {'redirect': overrideLocation});
//   //       return;
//   //     }
//   //   } catch (error) {
//   //     await ConnectionService.showConnectionErrorDialog();
//   //     await FlutterExitApp.exitApp(iosForceExit: true);
//   //     return;
//   //   }
//   // }

//   // if not authenticated, go directly to initialLocation instead of stacking home first
//   // if (session == null) {
//   //   _router.go(initialLocation);
//   //   return;
//   // }

//   // put the home screen in the stack first
//   _router.go('/');

//   // push initial location after the home screen if set
//   if (initialLocation != '/') {
//     // reset initial location
//     _initialLocation = '/';

//     // defering this seems to be necessary to ensure the previous route gets loaded
//     WidgetsBinding.instance.addPostFrameCallback((_) => _router.push(initialLocation));
//   }
// }