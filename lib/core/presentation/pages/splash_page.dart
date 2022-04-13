import 'package:login_task/core/presentation/blocs/auth/auth_bloc.dart';
import 'package:login_task/core/presentation/widgets/error_view.dart';
import 'package:login_task/core/presentation/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final AuthBloc authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(AuthCheckRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(
                  child: Loader(),
                ),
              );
            } else if (state is AuthFailure) {
              return Center(
                child: ErrorView(
                  failure: state.failure,
                  onRetry: () {
                    authBloc.add(AuthCheckRequested());
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
