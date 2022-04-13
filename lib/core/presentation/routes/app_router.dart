import 'package:auto_route/auto_route.dart';
import 'package:login_task/core/presentation/pages/splash_page.dart';
import 'package:login_task/features/auth/presentation/pages/profile/profile_page.dart';
import 'package:login_task/features/auth/presentation/pages/sign_in/sigin_page.dart';

export 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: [

    AutoRoute(page: SplashPage, initial: true),

    // Auth
    AutoRoute(
      page: SignInPage,
    ),

    // Profile Page
    AutoRoute(
      page: ProfilePage,
    ),

  ],
)
class $AppRouter {}
