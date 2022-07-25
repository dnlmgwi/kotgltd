import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kotgBlack,
          leading: IconButton(
            icon: Icon(Ionicons.chevron_back, color: kotgGreen),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            'Profile',
            style: GoogleFonts.sarala(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: kotgGreen,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(builder: (context, ref, _) {
                      final _profile = ref.watch(profileProvider);

                      return _profile.map(
                          loading: (loading) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 18, bottom: 15),
                                    child: ListTile(
                                      leading: Skeleton(
                                        height: 30,
                                        width: 30,
                                        style: SkeletonStyle.circle,
                                      ),
                                      title: Skeleton(
                                        height: 15,
                                        width: 15,
                                        style: SkeletonStyle.text,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    // leading: Icon(
                                    //   Ionicons.medal_outline,
                                    //   size: 40,
                                    // ),
                                    title: Text(
                                      'Member Since',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 5),
                                      child: Skeleton(
                                        height: 15,
                                        width: 15,
                                        style: SkeletonStyle.text,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 18, bottom: 15),
                                    child: Text(
                                      'Personal Details',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Name',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Skeleton(
                                      height: 15,
                                      width: 65,
                                      style: SkeletonStyle.text,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Birthday',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Skeleton(
                                      height: 15,
                                      width: 65,
                                      style: SkeletonStyle.text,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Gender',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Skeleton(
                                      height: 15,
                                      width: 65,
                                      style: SkeletonStyle.text,
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 18, bottom: 15),
                                    child: Text(
                                      'Contact Details',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    enabled: false,
                                    title: Text(
                                      'Email',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Skeleton(
                                      height: 15,
                                      width: 65,
                                      style: SkeletonStyle.text,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Phone Number',
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Skeleton(
                                      height: 15,
                                      width: 65,
                                      style: SkeletonStyle.text,
                                    ),
                                  ),
                                ],
                              ),
                          data: (data) {
                            bool enableNameField({
                              required String lastName,
                              required String firstName,
                            }) {
                              return data.value.profileAttributes.firstName
                                      .isNotEmpty &&
                                  data.value.profileAttributes.lastName
                                      .isNotEmpty;
                            }

                            bool enableDobField({
                              required String dateOfBirth,
                            }) {
                              return data.value.profileAttributes.dateOfBirth
                                  .isNotEmpty;
                            }

                            bool enableGenderField({
                              required String gender,
                            }) {
                              return data
                                  .value.profileAttributes.gender.isNotEmpty;
                            }

                            bool enablePhoneNumberField({
                              required String phoneNumber,
                            }) {
                              return data.value.profileAttributes.phoneNumber
                                  .isNotEmpty;
                            }

                            // final _phoneNumber =
                            //     ref.watch(phoneNumberProvider.state);

                            // void updatePhoneNumber( PhoneNumber phoneNumber) {
                            //   ref.read(phoneNumberProvider.state).state =
                            //       phoneNumber;
                            // }

                            // autofill() async {
                            //   String phoneNumber = await GetPhoneNumber().get();
                            //   updatePhoneNumber(
                            //       context,
                            //       PhoneNumber(
                            //           isoCode: IsoCode.MW,
                            //           nsn: phoneNumber.split('+265')[1]));
                            // }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 18, bottom: 15),
                                  child: ListTile(
                                    leading: TextAvatar(
                                      shape: Shape.Circular,
                                      textColor: Colors.white,
                                      fontSize: 30,
                                      upperCase: true,
                                      numberLetters: 2,
                                      text:
                                          data.value.profileAttributes.username,
                                    ),
                                    title: Text(
                                      data.value.profileAttributes.username,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  // leading: Icon(
                                  //   Ionicons.medal_outline,
                                  //   size: 40,
                                  // ),
                                  title: Text('Member Since'),
                                  subtitle: Text(timeago.format(
                                      data.value.profileAttributes.createdAt)),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 18, bottom: 15),
                                  child: Text(
                                    'Personal Details',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    'Name',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  enabled: !enableNameField(
                                    firstName:
                                        data.value.profileAttributes.firstName,
                                    lastName:
                                        data.value.profileAttributes.lastName,
                                  ),
                                  onTap: () => context.push(
                                      '/dashboard/profile/name?firstName=${data.value.profileAttributes.firstName}&lastName=${data.value.profileAttributes.lastName}'),
                                  trailing: Text(
                                      '${data.value.profileAttributes.firstName} ${data.value.profileAttributes.lastName}'),
                                ),
                                ListTile(
                                  enabled: !enableDobField(
                                      dateOfBirth: data
                                          .value.profileAttributes.dateOfBirth),
                                  title: Text(
                                    'Birthday',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onTap: () => context.push(
                                      '/dashboard/profile/birthday?dob=${data.value.profileAttributes.dateOfBirth}'),
                                  trailing: Text(
                                      data.value.profileAttributes.dateOfBirth),
                                ),
                                ListTile(
                                  enabled: !enableGenderField(
                                    gender: data.value.profileAttributes.gender,
                                  ),
                                  title: Text(
                                    'Gender',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onTap: () => context.push(
                                      '/dashboard/profile/gender?gender=${data.value.profileAttributes.gender}'),
                                  trailing:
                                      Text(data.value.profileAttributes.gender),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 18, bottom: 15),
                                  child: Text(
                                    'Contact Details',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  enabled: false,
                                  title: Text(
                                    'Email',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  trailing:
                                      Text(data.value.profileAttributes.email),
                                ),
                                ListTile(
                                  enabled: !enablePhoneNumberField(
                                      phoneNumber: data
                                          .value.profileAttributes.phoneNumber),
                                  title: Text(
                                    'Phone Number',
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onTap: () async {
                                    // await autofill();
                                    context.push(
                                        '/dashboard/profile/phoneNumber?phoneNumber=${data.value.profileAttributes.phoneNumber}');
                                  },
                                  trailing: Text(
                                      data.value.profileAttributes.phoneNumber),
                                ),
                              ],
                            );
                          },
                          error: (error) {
                            return Container(
                              child: Center(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enableFeedback: true,
                                        primary: kotgBlack,
                                        backgroundColor: kotgGreen,
                                      ),
                                      onPressed: () {
                                        ref.refresh(profileProvider);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Try Again",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ), //TODO Error Icon
                              ),
                            );
                          });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
