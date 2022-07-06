import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/auth/providers/email_password_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kotgBlack,
          leading: GestureDetector(
            child: Icon(Ionicons.chevron_back, color: kotgGreen),
            onTap: () {
              context.pop();
            },
          ),
          title: Text(
            'Create your account',
            style: GoogleFonts.sarala(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: kotgGreen,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 40.sp, right: 40.sp, top: 50.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HookConsumer(
                    builder: (context, ref, watch) {
                      final _repo = ref.read(authProvider);

                      final passwordVisibility =
                          ref.watch(passwordVisibilityProvider);
                      final _password = ref.watch(passwordProvider.state).state;
                      final _passwordCheck =
                          ref.watch(passwordCheckProvider.state).state;
                      final _email = ref.watch(emailProvider.state).state;
                      final _username = ref.watch(usernameProvider.state).state;
                      final _tc = ref.watch(tcProvider.state).state;

                      void updatePassword(BuildContext context, String pass) {
                        ref.read(passwordProvider.state).state = pass;
                      }

                      void updatePasswordCheck(
                          BuildContext context, String pass) {
                        ref.watch(passwordCheckProvider.state).state = pass;
                      }

                      void updateUsername(
                          BuildContext context, String username) {
                        ref.read(usernameProvider.state).state = username;
                      }

                      void updateEmail(BuildContext context, String email) {
                        ref.read(emailProvider.state).state = email;
                      }

                      void updateTermsAndConditions(
                          BuildContext context, bool tc) {
                        ref.read(tcProvider.state).state = tc;
                      }

                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 18),
                            //   child: Text(
                            //     'Create your account',
                            //     style: GoogleFonts.sarala(
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 25,
                            //       color: kotgGreen,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 15),
                              child: Text(
                                  'Play video game  tournaments & win prizes.',
                                  style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10.sp,
                                      color: Colors.grey)),
                            ),
                            TextFormField(
                              initialValue: _username,
                              inputFormatters: <TextInputFormatter>[
                                // FilteringTextInputFormatter.allow(
                                //     RegExp("[0-9a-zA-Z]")),
                                FilteringTextInputFormatter.deny(RegExp("[ ]")),
                                LengthLimitingTextInputFormatter(20),
                              ],
                              autofillHints: [AutofillHints.username],
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      color: kotgGreen,
                                      width: 2,
                                    )),
                                filled: false,
                                contentPadding: EdgeInsets.all(5.sp),
                                labelText: 'Username',
                                labelStyle: GoogleFonts.oxygen(
                                    color: kotgGreen,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),

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
                                initialValue: _email,
                                inputFormatters: <TextInputFormatter>[
                                  // FilteringTextInputFormatter.allow(
                                  //     RegExp("[0-9a-zA-Z]")),
                                  FilteringTextInputFormatter.deny(
                                      //TODO Prevent Spaces
                                      RegExp("[ ]")),
                                  LengthLimitingTextInputFormatter(125),
                                ],
                                autofillHints: [AutofillHints.email],
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.sp),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: kotgGreen,
                                        width: 2,
                                      )),
                                  filled: false,
                                  labelText: 'Email',
                                  labelStyle: GoogleFonts.oxygen(
                                      color: kotgGreen,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                // autofocus: true,
                                maxLines: 1,
                                onChanged: (String email) =>
                                    updateEmail(context, email),
                                showCursor: true,
                                // The validator receives the text that the user has entered.
                                validator: (value) =>
                                    !EmailValidator.validate(value!, true)
                                        ? 'Not a valid email.'
                                        : null),
                            SizedBox(
                              height: 15.sp,
                            ),
                            // PhoneFormField(
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   withHint: true,
                            //   decoration: InputDecoration(
                            //     focusedBorder: OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(5.0)),
                            //         borderSide:
                            //             BorderSide(color: kotgGreen, width: 2)),
                            //     filled: true,
                            //     contentPadding: EdgeInsets.all(13.sp),
                            //     labelText: 'Phone',
                            //     labelStyle: GoogleFonts.oxygen(
                            //         color: kotgGreen,
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            //   onChanged: (phone) =>
                            //       updatePhoneNumber(context, phone!),
                            //   defaultCountry: 'MW',
                            //   showFlagInInput: true,
                            //   phoneNumberType: PhoneNumberType.mobile,
                            //   selectorNavigator:
                            //       const BottomSheetNavigator(), // default to bottom sheet but you can customize how the selector is shown by extending CountrySelectorNavigator
                            //   lightParser:
                            //       false, // using true here reduce memory foot print but only use length to validate
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            TextFormField(
                              initialValue: _password,
                              inputFormatters: <TextInputFormatter>[
                                // FilteringTextInputFormatter.allow(
                                //     RegExp("[0-9a-zA-Z]")),

                                //TODO Prevent Length
                              ],
                              autofillHints: [AutofillHints.password],
                              obscureText: passwordVisibility,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5.sp),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      color: kotgGreen,
                                      width: 2,
                                    )),
                                filled: false,
                                labelText: 'Password',
                                labelStyle: GoogleFonts.oxygen(
                                    color: kotgGreen,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
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
                            SizedBox(
                              height: 15.sp,
                            ),
                            TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                // FilteringTextInputFormatter.allow(
                                //     RegExp("[0-9a-zA-Z]")),
                                FilteringTextInputFormatter.deny(
                                    //TODO Prevent Spaces
                                    RegExp("[ ]")),
                                //TODO Prevent Length
                              ],
                              autofillHints: [AutofillHints.password],
                              obscureText: passwordVisibility,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5.sp),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: kotgGreen, width: 2),
                                ),
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
                                        .read(passwordVisibilityProvider.state)
                                        .state = !passwordVisibility;
                                  },
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: GoogleFonts.oxygen(
                                    color: kotgGreen,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              maxLines: 1,
                              onChanged: (String password) =>
                                  updatePasswordCheck(context, password),
                              showCursor: true,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Re-enter your password';
                                }

                                if (_password != _passwordCheck) {
                                  return 'Passwords Do Not Match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            CheckboxListTile(
                                activeColor: kotgBlack,
                                checkColor: kotgGreen,
                                selected: false,
                                title: Text(
                                  'I accept the Terms and Conditions',
                                  style: GoogleFonts.oxygen(
                                    fontSize: 10.sp,
                                  ),
                                ),
                                tileColor: kotgBlack,
                                value: _tc,
                                onChanged: (value) {
                                  updateTermsAndConditions(context, value!);
                                }),
                            SizedBox(
                              height: 15.sp,
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
                              onPressed: () {
                                if (_tc == false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Please Accept T&C's"),
                                          backgroundColor: Colors.red));
                                }
                                if (!EmailValidator.validate(_email)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Enter a Valid Email'),
                                          backgroundColor: Colors.red));
                                }
                                //if form has been filled == true
                                if (_formKey.currentState!.validate() &&
                                    _tc == true) {
                                  context.loaderOverlay.show();
                                  _repo
                                      .signUp(
                                    username: _username,
                                    email: _email,
                                    password: _password,
                                  )
                                      .catchError((error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error!.toString()),
                                            backgroundColor: Colors.red));
                                  });
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5.sp),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.sp,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        enableFeedback: true,
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () => context.pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
