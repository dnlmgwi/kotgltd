import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/pages/sign_up_page.dart';
import 'package:kotgltd/features/auth/pages/widgets/forgot_password_widget.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/auth/providers/email_password_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.read(authProvider);
    final passwordVisibility =
        ref.watch(passwordVisibilityProvider.state).state;
    final _password = ref.watch(passwordProvider.state).state;
    final _username = ref.watch(usernameProvider.state).state;

    void updateUsername(BuildContext context, String username) {
      ref.read(usernameProvider.state).state = username;
    }

    void updatePassword(BuildContext context, String pass) {
      ref.read(passwordProvider.state).state = pass;
    }

    // void _showBottomSheetSignUp() async {
    //   await Get.bottomSheet(
    //     Container(
    //       width: double.infinity,
    //       height: 80.h,
    //       color: kotgBlack,
    //       child: SignUpPage(),
    //     ),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(
    //         top: Radius.circular(20),
    //       ),
    //     ),
    //   );

    //   // The code below will run after the bottom sheet goes away
    //   print('The Bottom Sheet has gone away!');
    // }

    void _showBottomSheetForgotPassword() async {
      await Get.bottomSheet(
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: kotgBlack,
          child: ForgotPasswordWidget(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isDismissible: false,
      );

      // The code below will run after the bottom sheet goes away
      print('The Bottom Sheet has gone away!');
    }

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 80.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15.sp,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/images/official_logo.json',
                                height: 110.sp,
                              ),
                              SizedBox(
                                height: 25.sp,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      inputFormatters: [
                                        // FilteringTextInputFormatter.allow(
                                        //     RegExp("[0-9a-zA-Z]")),
                                        FilteringTextInputFormatter.deny(
                                            RegExp("[ ]")),
                                      ],
                                      initialValue: _username,
                                      autofillHints: [AutofillHints.username],
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kotgGreen, width: 2)),
                                        filled: true,
                                        contentPadding: EdgeInsets.only(
                                            bottom: 10.sp,
                                            left: 10.sp,
                                            right: 10.sp),
                                        labelText: 'Email',
                                        labelStyle: GoogleFonts.oxygen(
                                            color: kotgGreen,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // autofocus: true,
                                      maxLines: 1,
                                      onChanged: (String username) =>
                                          updateUsername(context, username),
                                      showCursor: true,
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter valid Username';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    TextFormField(
                                      autofillHints: [
                                        AutofillHints.password,
                                      ],
                                      obscureText: passwordVisibility,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                                color: kotgGreen, width: 2)),
                                        filled: true,
                                        suffix: GestureDetector(
                                          child: passwordVisibility
                                              ? Icon(
                                                  Ionicons.eye_off,
                                                  color: kotgGreen,
                                                )
                                              : Icon(
                                                  Ionicons.eye,
                                                  color: kotgGreen,
                                                ),
                                          onTap: () {
                                            ref
                                                .read(passwordVisibilityProvider
                                                    .state)
                                                .state = !passwordVisibility;
                                          },
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 10.sp,
                                            left: 10.sp,
                                            right: 10.sp),
                                        labelText: 'Password',
                                        labelStyle: GoogleFonts.oxygen(
                                            color: kotgGreen,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                        // border: InputBorder.none,
                                      ),

                                      maxLines: 1,
                                      onChanged: (String value) =>
                                          updatePassword(context, value),
                                      showCursor: true,
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter valid Password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.sp,
                  ),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enableFeedback: true,
                      primary: kotgBlack,
                      backgroundColor: kotgGreen,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.loaderOverlay.show();
                        _repo
                            .signIn(password: _password, email: _username)
                            .catchError((error) {
                          context.loaderOverlay.hide();
                          Get.snackbar(
                            "Connection Error",
                            error!.toString(),
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        });
                      }
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        enableFeedback: true,
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () => Get.to(SignUpPage()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  TextButton(
                    style: ButtonStyle(
                        enableFeedback: true,
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () => _showBottomSheetForgotPassword(),
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
