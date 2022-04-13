import 'package:login_task/core/presentation/blocs/auth/auth_bloc.dart';
import 'package:login_task/core/presentation/widgets/custom_app_bar.dart';
import 'package:login_task/core/presentation/widgets/screen_loader.dart';
import 'package:login_task/core/presentation/widgets/screen_utils.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/presentation/blocs/logout_remote/logout_remote_bloc.dart';
import 'package:login_task/gen/assets.gen.dart';
import 'package:login_task/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with ScreenUtils, ScreenLoader {
  final LogoutRemoteBloc logoutRemoteBloc = getIt<LogoutRemoteBloc>();

  late final AuthBloc authBloc;
  late final UserInfo user;
  late final bool isSignedInWithGoogle;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    user = (authBloc.state as Authenticated).user;
    isSignedInWithGoogle =
        (authBloc.state as Authenticated).isSignedInWithGoogle;
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          isSignedInWithGoogle ? 'signed_in_with_google'.tr(): 'signed_in_with_email'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              logoutRemoteBloc.add(LogoutRemoteOnSubmit());
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 32, bottom: 20, left: 22, right: 22),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.whiteMap1.path),
              fit: BoxFit.cover,
            ),
            color: Colors.grey.shade300),
        child: BlocListener<LogoutRemoteBloc, LogoutRemoteState>(
          bloc: logoutRemoteBloc,
          listener: (context, state) {
            if (state is LogoutRemoteLoading) {
              startLoading();
            }
            if (state is LogoutRemoteFailure) {
              stopLoading();
              handleError(
                failure: state.failure,
              );
            } else if (state is LogoutRemoteSuccessful) {
              stopLoading();
              if (state.success) {
                authBloc.add(AuthLogout());
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'welcome'.tr() + ', ',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                user.email,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )
        ),
      ),
    );
  }
}
