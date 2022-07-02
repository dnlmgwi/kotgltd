import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/settings/settings_page.dart';
import 'package:kotgltd/features/team/pages/team_page.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/events/pages/events_page.dart';
import 'package:kotgltd/features/home/pages/home_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DashboardPage extends ConsumerWidget {
  DashboardPage({Key? key}) : super(key: key);
  final pageWidgets = [
    // TransactionsPage(),
    HomePage(),
    EventsPage(),
    // VirtualCardPage(),
    // WalletPage(),
    TeamsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context, ref) {
    final _page = ref.watch(pageProvider.state);
    // final _account = ref.watch(balanceProvider);

    // Future<void> _refreshEvents(BuildContext context) async {
    //   return ref.refresh(eventsRepoProvider);
    // }

    // Future<void> _refreshBalance(BuildContext context) async {
    //   return ref.refresh(balanceProvider);
    // }

    // var network = ref.watch(networkAwareProvider);
    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kotgBlack,
        //   elevation: 0.0,
        //   actions: [
        //   FadeIn(
        //     child: _account.map(
        //         data: (data) => Padding(
        //               padding: EdgeInsets.only(right: 25.sp),
        //               child: Container(
        //                 height: 10.h,
        //                 child: Center(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Icon(
        //                           Ionicons.ticket_outline,
        //                         ),
        //                       ),
        //                       Text(
        //                         '${(data.value.balance.toString()).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
        //                         style: GoogleFonts.poppins(
        //                             fontWeight: FontWeight.w600,
        //                             fontSize: 25.sp,
        //                             color: Colors.grey),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //         loading: (loading) => Padding(
        //               padding: const EdgeInsets.only(right: 25.0),
        //               child: Center(
        //                   child: Skeleton(
        //                       height: 12.sp,
        //                       width: 25.w,
        //                       style: SkeletonStyle.text)),
        //             ),
        //         error: (error) => Padding(
        //               padding: const EdgeInsets.only(right: 25.0),
        //               child: Center(
        //                 child: Container(
        //                   width: 25.w,
        //                   child: ElevatedButton.icon(
        //                     style: OutlinedButton.styleFrom(
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(5.0),
        //                       ),
        //                       enableFeedback: true,
        //                       primary: kotgBlack,
        //                       backgroundColor: kotgGreen,
        //                     ),
        //                     icon: Icon(Ionicons.refresh_outline),
        //                     label: Text(
        //                       'Retry',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     onPressed: () {
        //                       _refreshBalance(context);
        //                     },
        //                   ),
        //                 ), //TODO Error Icon
        //               ),
        //             )),
        //   ),
        //   ],
        // ),
        body: pageWidgets.elementAt(_page.state),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page.state,
          onTap: (value) {
            _page.state = value;
          },
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: kotgGreen, fontSize: 10.sp),
          unselectedFontSize: 10.sp,
          selectedIconTheme: IconThemeData(color: kotgGreen, size: 20.sp),
          unselectedItemColor: Colors.white54,
          enableFeedback: true,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white54,
          backgroundColor: kotgBlack,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Feed',
              icon: Icon(Ionicons.albums_outline),
            ),
            BottomNavigationBarItem(
              label: 'Events',
              icon: Icon(Ionicons.ticket_outline),
            ),
            BottomNavigationBarItem(
              label: 'Teams',
              icon: Icon(Ionicons.people_outline),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(
                Ionicons.settings_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// _profile.map(
//                           loading: (loading) => CircularProgressIndicator(),
//                           data: (data) {
//                             context.loaderOverlay.hide();
//                             return Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipOval(
//                                   child: Image.network(
//                                     data.value['profile']['avatar']['image'][
//                                         'url'], //TODO Handle Image Error with Cached Netowrk Image
//                                     width: 40,
//                                     height: 40,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 )
//                               ],
//                             );
//                           },
//                           error: (error) {
//                             context.loaderOverlay.show();

//                             return Container();
//                           },
//                         ),
                      