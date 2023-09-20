import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/screens/login_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/username_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeURL = "/";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    // final result = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const LoginScreen(data: data),
    //   ),
    // );
    // print(result);
    final result = await context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTab(BuildContext context) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 5),
    //     reverseTransitionDuration: const Duration(seconds: 5),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation = Tween(
    //         begin: const Offset(0, -1),
    //         end: Offset.zero,
    //       ).animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         ),
    //       );
    //     },

    //     /** animation transition example */
    //     // transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //     //     ScaleTransition(
    //     //   scale: animation,
    //     //   alignment: Alignment.bottomRight,
    //     //   child: FadeTransition(
    //     //     opacity: animation,
    //     //     child: child,
    //     //   ),
    //     // ),
    //   ),
    // );
    // context.push(UsernameScreen.routeName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );

    // context.push("/users/31seul", extra: {"show": "likes"});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(Localizations.localeOf(context));
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v60,
                  const Text(
                    "Sign up to TikTok",
                    // S.of(context).signUpTitle("TikTok", DateTime.now()),
                    // AppLocalizations.of(context)!.signUpTitle("TikTok"),
                    // style: Theme.of(context).textTheme.headlineMedium!
                    // .copyWith(color: Colors.red),
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Another fonts",
                    style: GoogleFonts.itim(
                      textStyle: const TextStyle(fontSize: Sizes.size28),
                    ),

                    // .copyWith(color: Colors.red),
                  ),
                  Gaps.v10,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(2),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTab(context),
                      child: AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.solidUser),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: () => ref
                          .read(socialAuthProvider.notifier)
                          .githubSignIn(context),
                      child: AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.github),
                        text: S.of(context).appleButton,
                      ),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTab(context),
                            child: const AuthButton(
                              icon: FaIcon(FontAwesomeIcons.solidUser),
                              // text: S.of(context).emailPasswordButton,
                              text: "Use email & password",
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => ref
                                .read(socialAuthProvider.notifier)
                                .githubSignIn(context),
                            child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.github),
                              text: S.of(context).appleButton,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            color: isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      // S.of(context).login('male'),
                      "Log In",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
