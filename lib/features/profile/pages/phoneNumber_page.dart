import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberPage extends ConsumerWidget {
  PhoneNumberPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String phoneNumber;

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.watch(profileRepoProvider);
    final _phoneNumber = ref.watch(phoneNumberProvider.state);

    void updatePhoneNumber(BuildContext context, PhoneNumber phoneNumber) {
      ref.read(phoneNumberProvider.state).state = phoneNumber;
    }

    return Scaffold(
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
          'Phone Number',
          style: GoogleFonts.sarala(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: kotgGreen,
          ),
        ),
      ),
      body: LoaderOverlay(
        overlayOpacity: 0.8,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Consumer(builder: (context, watch, _) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PhoneFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofillHints: [
                          AutofillHints.telephoneNumber
                        ], // default to null
                        enabled: true, // default
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: kotgGreen, width: 2)),
                          contentPadding: EdgeInsets.all(10.sp),
                          labelText: 'Phone',
                          labelStyle: GoogleFonts.oxygen(
                              color: kotgGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        onChanged: (phone) =>
                            updatePhoneNumber(context, phone!),
                        defaultCountry: IsoCode.MW,
                        showFlagInInput: true,
                        initialValue: _phoneNumber.state,
                        validator: PhoneValidator.validMobile(),
                        enableInteractiveSelection: true,
                        // initialValue: phoneNumber,
                        countrySelectorNavigator:
                            CountrySelectorNavigator.bottomSheet(),
                      ),
                      SizedBox(
                        height: 35,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            _repo
                                .updatePhoneNumber(
                              phoneNumber: _phoneNumber.state,
                            )
                                .then((value) {
                              context.loaderOverlay.hide();
                              ref.refresh(profileProvider);
                              context.pop();
                            }).catchError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));

                              context.loaderOverlay.hide();
                            });
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Save",
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
              }),
            ),
          ),
        ),
      ),
    );
  }
}
