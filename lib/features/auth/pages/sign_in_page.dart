import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
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

    final _email = ref.watch(emailProvider.state).state;

    void updateEmail(BuildContext context, String email) {
      ref.read(emailProvider.state).state = email;
    }

    void updatePassword(BuildContext context, String pass) {
      ref.read(passwordProvider.state).state = pass;
    }

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        body:
            // Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/controller.jpg"),
            //     fit: BoxFit.fitHeight,
            //   ),
            // ),
            // child: BackdropFilter(
            // filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            // child:
            Center(
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
                                      initialValue: _email,
                                      autofillHints: [AutofillHints.username],
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10.sp),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                                color: kotgGreen, width: 2)),
                                        filled: false,
                                        labelText: 'Email',
                                        labelStyle: GoogleFonts.oxygen(
                                            color: kotgGreen,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // autofocus: true,
                                      maxLines: 1,

                                      onChanged: (String username) =>
                                          updateEmail(context, username),
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
                                        filled: false,
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
                                        contentPadding: EdgeInsets.all(10.sp),
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
                            .signIn(password: _password, email: _email)
                            .catchError((error) {
                          context.loaderOverlay.hide();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error!.toString()),
                              backgroundColor: Colors.red));
                        });
                      }
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        enableFeedback: true,
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () {
                      context.push('/auth/register');
                    },
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
                  // TextButton(
                  //   style: ButtonStyle(
                  //       enableFeedback: true,
                  //       splashFactory: NoSplash.splashFactory),
                  //   onPressed: () => context.push('/auth/forgot-password'),
                  //   child: Text(
                  //     "Forgot your password?",
                  //     style: TextStyle(color: Colors.grey),
                  //   ),
                  // ) //TODO Unhide Forgot Password
                ],
              ),
            ),
          ),
        ),
      ),
      // ),
      // ),
    );
  }
}
