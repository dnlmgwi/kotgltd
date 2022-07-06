import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class BirthdayPage extends ConsumerWidget {
  BirthdayPage({
    Key? key,
    required this.birthday,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String birthday;

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.watch(profileRepoProvider);
    final _dateofBirth = ref.watch(dateOfBirthProvider.state);

    final _dateofBirthFormatted =
        ref.watch(dateOfBirthFinalProvider(_dateofBirth.state).state);
    void updateDateofBirth(BuildContext context, DateTime dateOfBirth) {
      ref.read(dateOfBirthProvider.state).state = dateOfBirth;
    }

    // void updateDetails(
    //   BuildContext context,
    //   String lastName,
    //   String firstName,
    // ) {
    //   if (lastName.isEmpty) lastName = _lastName.state;
    //   if (firstName.isEmpty) firstName = _firstName.state;

    //   if (lastName.isNotEmpty) updateLastName(context, lastName);
    //   if (firstName.isNotEmpty) updateFirstName(context, firstName);
    // }

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
          'Birthday',
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
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        child: SizedBox(
                          height: 150.sp,
                          child: ScrollDatePicker(
                            style: DatePickerStyle(
                              textStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            selectedDate: _dateofBirth.state,
                            locale: DatePickerLocale.enUS,
                            onDateTimeChanged: (DateTime value) {
                              updateDateofBirth(context, value);
                            },
                          ),
                        ),
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
                          // updateDetails(context, lastName, firstName);
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            _repo
                                .updateDateOfBirth(
                              dateOfBirth: _dateofBirthFormatted.state,
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
