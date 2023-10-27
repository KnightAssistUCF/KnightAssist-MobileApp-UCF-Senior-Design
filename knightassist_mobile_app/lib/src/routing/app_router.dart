import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/register/register_organization_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/register/register_student_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/routing/go_router_refresh_stream.dart';
import 'package:knightassist_mobile_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute { home, event, account, signIn, registerStudent, registerOrg }

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: false,
      redirect: (context, state) {
        final isLoggedIn = authRepository.currentUser != null;
        final path = state.uri.path;
        if (isLoggedIn) {
          if (path == '/signIn') {
            return '/';
          }
        } else {
          if (path == '/account') {
            return '/';
          }
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) =>
                const EventsListScreen(), // TEMP, change this to whatever screen you want to test (will need to rerun)
            routes: [
              GoRoute(
                  path: 'event/:id',
                  name: AppRoute.event.name,
                  builder: (context, state) {
                    final eventId = state.pathParameters['id']!;
                    return EventScreen(eventID: eventId);
                  }),
              GoRoute(
                  path: 'account',
                  name: AppRoute.account.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: AccountScreen())),
              GoRoute(
                  path: 'signIn',
                  name: AppRoute.signIn.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: SignInScreen())),
              GoRoute(
                  path: 'registerStudent',
                  name: AppRoute.registerStudent.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: RegisterStudentScreen())),
              GoRoute(
                  path: 'registerOrg',
                  name: AppRoute.registerOrg.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true,
                      child: RegisterOrganizationScreen())),
            ])
      ],
      errorBuilder: (context, state) => const NotFoundScreen());
}