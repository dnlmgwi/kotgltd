import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/profile/widgets/update_profile_widget.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _auth = ref.read(authProvider);

    // final _system = ref.watch(systemStatusProvider);
    final Uri _urlGef = Uri.parse('https://www.globalesports.org/');
    final Uri _urlFeedback = Uri.parse('https://forms.gle/R7ctyVzPgN6KupTj7');
    final Uri _urlWA =
        Uri.parse(r'''https://wa.me/265997176756?text=KOTG%20Feedback''');

    void _launchGEFURL() async {
      if (!await launch(_urlGef.toString())) throw 'Could not launch $_urlGef';
    }

    void _launchFeedbackURL() async {
      if (!await launch(_urlFeedback.toString()))
        throw 'Could not launch $_urlFeedback';
    }

    void _launchWAURL() async {
      if (!await launch(_urlWA.toString())) throw 'Could not launch $_urlWA';
    }

    void _showEventDestailsBottomSheet() async {
      await Get.bottomSheet(Container(
        color: kotgBlack,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 18,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35, bottom: 25),
                      child: Text(
                        'Partners',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          fontSize: 26.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 35, bottom: 25),
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Ionicons.close,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35, left: 35, bottom: 25),
                child: Center(
                  child: Container(
                    child: Text('Coming Soon!'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 18, bottom: 25),
              child: Text(
                'Options',
                style: GoogleFonts.sarala(
                  fontWeight: FontWeight.w600,
                  fontSize: 26.sp,
                  color: kotgGreen,
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 15, top: 18, bottom: 25),
            //       child: Consumer(builder: (context, ref, _) {
            //         final _profile = ref.watch(profileProvider);

            //         return FadeIn(
            //           delay: Duration(milliseconds: 500),
            //           child: _profile.map(
            //             loading: (loading) => CircularProgressIndicator(),
            //             data: (data) => Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 ClipOval(
            //                   child: Image.network(
            //                     data.value['avatar']['image']['url'],
            //                     width: 80,
            //                     height: 80,
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             error: (error) {
            //               context.loaderOverlay.show();
            //               return Container();
            //             },
            //           ),
            //         );
            //       }),
            //     ),
            //   ],
            // ),

            // ListTile(leading: LineIcon.user(), title: Text('Profile')),
            // ListTile(leading: LineIcon.tools(), title: Text('Settings')),
            // ListTile(leading: LineIcon.donate(), title: Text('Donate')),
            // ListTile(leading: LineIcon.award(), title: Text('Benefits')),
            // ListTile(leading: LineIcon.whatSApp(), title: Text('Feedback')),
            // ListTile(
            //     leading: LineIcon.questionCircleAlt(),
            //     title: Text('Support')),
            // _system.map(
            //   data: (data) => Container(
            //     height: 50,
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             '${data.value['message']} v${data.value['version']}',
            //             style: GoogleFonts.poppins(
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 10.sp,
            //                 color: Colors.grey),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            //   loading: (loading) => Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Center(
            //         child: Skeleton(
            //             height: 12, width: 50.w, style: SkeletonStyle.text)),
            //   ),
            //   error: (error) => Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Container(
            //       height: 130,
            //       child: Center(
            //         child: Text(
            //           'Token System in Unavaliable',
            //         ), //TODO Error Icon
            //       ),
            //     ),
            //   ),
            // ),
            ListTile(
              leading: LineIcon.user(),
              title: Text('Profile'),
              onTap: () => Get.to(UpdateProfileWidget()),
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                      child: Text(
                        'Settings',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: LineIcon.doorOpen(),
                      title: Text('Logout'),
                      enableFeedback: true,
                      onTap: () => _auth.logout(),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                      child: Text(
                        'General',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // ListTile(
                    //   leading: LineIcon.donate(),
                    //   title: Text(
                    //     'Donate',
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: LineIcon.link(),
                    //   title: Text('iMind Mental Health'),
                    //   subtitle: Text('in partnership with iMind Malawi'),
                    //   enabled: false,
                    // ),
                    ListTile(
                      leading: LineIcon.link(),
                      title: Text('Global Esports Federation'),
                      subtitle: Text('A Proud Affiliate'),
                      enabled: true,
                      enableFeedback: true,
                      onTap: () async {
                        _launchGEFURL();
                      },
                    ),
                    // ListTile(
                    //   leading: LineIcon.award(),
                    //   title: Text('Benefits'),
                    //   enabled: false,
                    // ),
                    ListTile(
                      leading: LineIcon.file(),
                      title: Text('Feedback'),
                      enabled: true,
                      enableFeedback: true,
                      onTap: () async {
                        _launchFeedbackURL();
                      },
                    ),
                    ListTile(
                      leading: LineIcon.peopleCarry(),
                      title: Text('Partners'),
                      enableFeedback: true,
                      enabled: true,
                      onTap: () {
                        _showEventDestailsBottomSheet();
                      },
                    ),
                    ListTile(
                      leading: LineIcon.phone(),
                      title: Text('Contact Us'),
                      enableFeedback: true,
                      enabled: true,
                      onTap: () async {
                        _launchWAURL();
                      },
                    ),
                    // ListTile(
                    //   leading: LineIcon.questionCircleAlt(),
                    //   title: Text('FAQs'),
                    //   enableFeedback: true,
                    //   enabled: false,
                    //   onTap: () {},
                    // ),
                    // Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                      child: Text(
                        'Legal',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: LineIcon.fileContract(),
                      title: Text('Privacy Policies'),
                      enableFeedback: true,
                      enabled: false,
                      onTap: () {},
                    ),
                    ListTile(
                      leading: LineIcon.fileContract(),
                      title: Text('Terms & Condtions'),
                      enableFeedback: true,
                      enabled: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  'KOTG Esports Ltd.',
                  style: GoogleFonts.sarala(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
