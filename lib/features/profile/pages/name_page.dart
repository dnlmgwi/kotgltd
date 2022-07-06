import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NamePage extends ConsumerWidget {
  NamePage({
    Key? key,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.watch(profileRepoProvider);
    final _firstName = ref.watch(firstNameProvider.state);
    final _lastName = ref.watch(lastNameProvider.state);

    void updateFirstName(BuildContext context, String firstName) {
      ref.read(firstNameProvider.state).state = firstName.trim();
    }

    void updateLastName(BuildContext context, String lastName) {
      ref.read(lastNameProvider.state).state = lastName.trim();
    }

    void updateDetails(
      BuildContext context,
      String lastName,
      String firstName,
    ) {
      if (lastName.isEmpty) lastName = _lastName.state;
      if (firstName.isEmpty) firstName = _firstName.state;

      if (lastName.isNotEmpty) updateLastName(context, lastName);
      if (firstName.isNotEmpty) updateFirstName(context, firstName);
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
          'Display Name',
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
                      TextFormField(
                        initialValue: firstName,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.sp),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: kotgGreen, width: 2)),
                          filled: false,
                          labelText: 'Firstname',
                          labelStyle: GoogleFonts.oxygen(
                              color: kotgGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),

                        maxLines: 1,
                        onChanged: (String firstName) =>
                            updateFirstName(context, firstName),
                        showCursor: true,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid Firstname';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: lastName,
                        keyboardType: TextInputType.name,

                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: kotgGreen, width: 2)),
                          filled: false,
                          contentPadding: EdgeInsets.all(10.sp),
                          labelText: 'Lastname',
                          labelStyle: GoogleFonts.oxygen(
                              color: kotgGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        // autofocus: true,
                        maxLines: 1,
                        onChanged: (String lastName) =>
                            updateLastName(context, lastName),
                        showCursor: true,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid Last Name';
                          }
                          return null;
                        },
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
                        onPressed: () {
                          updateDetails(context, lastName, firstName);
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            _repo
                                .updateName(
                              firstName: _firstName.state,
                              lastName: _lastName.state,
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
