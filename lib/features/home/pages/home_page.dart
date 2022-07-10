import 'package:animate_do/animate_do.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/Tickets/pages/tickets_page.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/home/page_provider.dart';
// import 'package:kotgltd/features/reminder/providers/reminder_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:share_plus/share_plus.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, ref) {
    final _user = ref.watch(currentUserProvider);
    // final _page = ref.watch(pageProvider.state);
    // final _reminder = ref.watch(addRemiderProvider);

    Future<void> _refreshFeed(BuildContext context) async {
      return ref.refresh(eventsRepoProvider);
    }

    void _showTicketsPageBottomSheet() async {
      await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => TicketsPage(),
      );

      print('The Bottom Sheet has gone away!');
    }

    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 15.sp, top: 18.sp, bottom: 25.sp, right: 15.sp),
            child: Consumer(builder: (context, ref, _) {
              return FadeIn(
                delay: Duration(milliseconds: 500),
                child: _user.map(
                  loading: (loading) => CircularProgressIndicator(),
                  data: (data) =>
                      // Row(
                      //   children: [

                      //     ),
                      //     Spacer(),
                      //     TextAvatar(
                      //       shape: Shape.Circular,
                      //       size: 50,
                      //       textColor: Colors.white,
                      //       fontSize: 35,
                      //       upperCase: true,
                      //       numberLetters: 2,
                      //       text: data.value!.username,
                      //     ),
                      //   ],
                      // ),
                      ListTile(
                          leading: TextAvatar(
                            shape: Shape.Circular,
                            size: 50,
                            textColor: Colors.white,
                            fontSize: 35,
                            upperCase: true,
                            numberLetters: 2,
                            text: data.value!.username,
                          ),
                          subtitle: Text(
                            data.value!.email,
                            style: GoogleFonts.sarala(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Icon(LineIcons.editAlt),
                          onTap: () => context.push('/dashboard/profile'),
                          title: Text(
                            'Welcome, ${data.value!.username}',
                            style: GoogleFonts.sarala(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          )),
                  error: (error) => Container(
                    height: 130.sp,
                    child: Center(
                      child: Container(
                        width: 50.w,
                        child: ElevatedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enableFeedback: true,
                            primary: kotgBlack,
                            backgroundColor: kotgGreen,
                          ),
                          icon: Icon(Ionicons.ticket_outline),
                          label: Text(
                            'Try Again',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            ref.refresh(currentUserProvider);
                          },
                        ),
                      ),
                      //TODO Error Icon
                    ),
                  ),
                ),
              );
            }),
          ),
          ListTile(
            trailing: Icon(Icons.chevron_right),
            // leading: Icon(Ionicons.ticket_outline),
            title: Text(
              'My Tickets',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => context.push('/dashboard/tickets'),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.sp,
              top: 18,
            ),
            child: Text(
              "Discover",
              style: GoogleFonts.sarala(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 15.sp),
            ),
          ),
        ],
      ),
    ));
  }
}
