import 'package:google_fonts/google_fonts.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/auth/providers/email_password_providers.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ForgotPasswordPage extends ConsumerWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  // final TextEditingController controller = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController createInviteCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final _userRepo = ref.watch(authRepoProvider);
    final _email = ref.watch(emailProvider.state);

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        'Forgot Password',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: kotgGreen,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('Check your emails and follow the steps',
                          style: GoogleFonts.sarala(
                              fontWeight: FontWeight.normal,
                              fontSize: 10.sp,
                              color: Colors.grey)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: teamNameController,

                                inputFormatters: [
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
                                    _email.state = email,
                                showCursor: true,
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
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
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Send Email",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.loaderOverlay.show();
                                    _userRepo
                                        .forgotPassword(email: _email.state)
                                        .onError((error, stackTrace) {
                                      context.loaderOverlay.hide();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(error!.toString()),
                                              backgroundColor: Colors.red));
                                    }).whenComplete(() => context.pop());
                                  }
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
          ),
        ),
      ),
    );
  }
}
