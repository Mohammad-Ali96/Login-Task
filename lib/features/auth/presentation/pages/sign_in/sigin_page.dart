import 'package:login_task/core/presentation/blocs/auth/auth_bloc.dart';
import 'package:login_task/core/presentation/utils/validation_util.dart';
import 'package:login_task/core/presentation/widgets/custom_password_text_field.dart';
import 'package:login_task/core/presentation/widgets/custom_text_field.dart';
import 'package:login_task/core/presentation/widgets/screen_loader.dart';
import 'package:login_task/core/presentation/widgets/screen_utils.dart';
import 'package:login_task/features/auth/domain/usecases/sign_in_with_email_use_case.dart';
import 'package:login_task/features/auth/presentation/blocs/sign_in_with_email/sign_in_with_email_bloc.dart';
import 'package:login_task/features/auth/presentation/blocs/sign_in_with_google/sign_in_with_google_bloc.dart';
import 'package:login_task/gen/assets.gen.dart';
import 'package:login_task/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with ScreenUtils, ScreenLoader {
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> emailFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordFormFieldKey =
      GlobalKey<FormFieldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final SignInWithEmailBloc signInBloc = getIt<SignInWithEmailBloc>();
  final SignInWithGoogleBloc signInWithGoogleBloc =
      getIt<SignInWithGoogleBloc>();

  late final AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 32, bottom: 20, left: 22, right: 22),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.whiteMap1.path),
              fit: BoxFit.cover,
            ),
            color: Colors.grey.shade300),
        child: MultiBlocListener(
          listeners: [
            BlocListener<SignInWithEmailBloc, SignInWithEmailState>(
              bloc: signInBloc,
              listener: (context, state) {
                if (state is SignInWithEmailLoading) {
                  startLoading();
                }
                if (state is SignInWithEmailFailure) {
                  stopLoading();
                  handleError(
                    failure: state.failure,
                  );
                } else if (state is SignInWithEmailSuccessful) {
                  stopLoading();
                  authBloc.add(AuthLogin(state.user, false));
                }
              },
            ),
            BlocListener<SignInWithGoogleBloc, SignInWithGoogleState>(
              bloc: signInWithGoogleBloc,
              listener: (context, state) {
                if (state is SignInWithGoogleLoading) {
                  startLoading();
                }
                if (state is SignInWithGoogleFailure) {
                  stopLoading();
                  handleError(
                    failure: state.failure,
                  );
                } else if (state is SignInWithGoogleSuccessful) {
                  stopLoading();
                  authBloc.add(AuthLogin(state.user, true));
                }
              },
            ),
          ],
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    FlutterLogo(size: width / 2.5),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextField(
                      textEditingController: emailController,
                      formFieldKey: emailFormFieldKey,
                      labelText: 'email'.tr(),
                      hintText: 'example@example.com'.tr(),
                      keyboardType: TextInputType.emailAddress,
                      validator: Validation.emailValidator,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    CustomPasswordTextField(
                      textEditingController: passwordController,
                      formFieldKey: passwordFormFieldKey,
                      labelText: 'password'.tr(),
                      hintText: '* * * * * * * *',
                      obscureText: true,
                      validator: Validation.passwordValidator,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'forget_password?'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (!Validation.validateAndSave(formKey)) {
                            return;
                          }
                          signInBloc
                              .add(SignInOnSubmit(SignInWithEmailUseCaseParams(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.login, size: 24),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'sign_in_with_email'.tr() + '     ',
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'or'.tr(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signInWithGoogleBloc.add(SignInWithGoogleOnSubmit());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.google, size: 20),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'sign_in_with_google'.tr() + '     ',
                            style: const TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      onTap: (){},
                      child: RichText(
                        text: TextSpan(
                          text: 'do_not_have_an_account?'.tr() + ' ',
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(
                              text: 'sign_up'.tr(),
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              )
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
