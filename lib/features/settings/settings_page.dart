import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icon.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _auth = ref.read(authProvider);

    final Uri _urlDiscord = Uri.parse('https://discord.gg/kF7kng6xXt');

    void _launchDiscordURL() async {
      if (!await launchUrl(_urlDiscord)) throw 'Could not launch $_urlDiscord';
    }

    void _showEventDestailsBottomSheet() async {
      await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => Container(
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
                            onPressed: () => context.pop(),
                            icon: Icon(
                              Ionicons.close,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 35, left: 35, bottom: 25),
                  child: Center(
                    child: Container(
                      child: Text('Coming Soon!'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
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
              onTap: () => context.push('/dashboard/profile'),
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
                        'Billing',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Ionicons.receipt_outline),
                      title: Text('Transactions'),
                      subtitle: Text('Coming Soon'),
                      enableFeedback: true,
                      enabled: false,
                      onTap: () {},
                    ),
                    Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                      child: Text(
                        'Support',
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
                    // ListTile(
                    //   leading: LineIcon.link(),
                    //   title: Text('Global Esports Federation'),
                    //   subtitle: Text('A Proud Affiliate'),
                    //   enabled: true,
                    //   enableFeedback: true,
                    //   onTap: () async {
                    //     _launchGEFURL();
                    //   },
                    // ),
                    // ListTile(
                    //   leading: LineIcon.award(),
                    //   title: Text('Benefits'),
                    //   enabled: false,
                    // ),
                    // ListTile(
                    //   leading: LineIcon.file(),
                    //   title: Text('Feedback'),
                    //   enabled: true,
                    //   enableFeedback: true,
                    //   onTap: () async {
                    //     _launchFeedbackURL();
                    //   },
                    // ),
                    // ListTile(
                    //   leading: LineIcon.peopleCarry(),
                    //   title: Text('Partners'),
                    //   enableFeedback: true,
                    //   enabled: true,
                    //   onTap: () {
                    //     _showEventDestailsBottomSheet();
                    //   },
                    // ),
                    ListTile(
                      leading: Icon(Ionicons.logo_discord),
                      title: Text('Contact Us'),
                      subtitle:
                          Text('For any event related or prompt assistance '),
                      enableFeedback: true,
                      enabled: true,
                      onTap: () async {
                        _launchDiscordURL();
                      },
                    ),
                    ListTile(
                      leading: Icon(Ionicons.mail_unread_outline),
                      title: Text('Email Us'),
                      subtitle: Text('For feedback and suggestions.'),
                      enableFeedback: true,
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: 'info@kotg.club'));

                        Fluttertoast.showToast(
                            msg: 'Copied to Clipboard: info@kotg.club',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            fontSize: 10.0.sp);
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
                      title: Text('Privacy Policy'),
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
                    Divider(),
                    ListTile(
                      leading: LineIcon.doorOpen(),
                      title: Text('Logout'),
                      enableFeedback: true,
                      onTap: () => _auth.logout(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  'KOTG Ltd.',
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
