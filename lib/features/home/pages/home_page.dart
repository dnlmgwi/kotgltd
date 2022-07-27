import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/Tickets/pages/tickets_page.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/home/widgets/game_card.dart';
// import 'package:kotgltd/features/reminder/providers/reminder_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
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

    final data = [
      {
        "url":
            "https://factschronicle.com/wp-content/uploads/2019/03/apex-legends-season-1-start-date-loot-battle-pass-weapons.jpg",
        "name": "Apex Legends"
      },
      {
        "url":
            "https://cdn1.dotesports.com/wp-content/uploads/2020/05/24064824/call-of-duty-mobile-hero-a.jpg",
        "name": "COD: Mobile"
      },
      {
        "url":
            "https://4.bp.blogspot.com/-qg0tY0LwhLw/W2Otq6IwJmI/AAAAAAAAOrQ/3F1NrTT0da0LMETQHpBR6wjuWht_DzFIQCLcBGAs/s1600/Download%2BPUBG%2BMOBILE.png",
        "name": "PUGB: Mobile"
      },
      {
        "url":
            "https://assets.gamepur.com/wp-content/uploads/2020/10/15192943/Rogue-Company.jpg",
        "name": "Rogue Company"
      },
      {
        "url":
            "https://cdn2.unrealengine.com/egs-rocketleague-psyonixllc-s3-2560x1440-56d55e752216.jpg",
        "name": "Rocket League"
      }
    ];

    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.sp, top: 18.sp, right: 15.sp),
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
                          trailing: Icon(Ionicons.create_outline),
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
          Divider(),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: ListTile(
                onTap: () => context.push('/dashboard/tickets'),
                leading: Icon(Ionicons.ticket_outline, color: Colors.white70),
                trailing: Icon(Icons.chevron_right),
                // leading: Icon(Ionicons.ticket_outline),
                title: Text(
                  'My Tickets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15.sp,
                right: 15.sp,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Discover",
                    style: GoogleFonts.sarala(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12.sp),
                  ),
                  // Text(
                  //   "See More",
                  //   style: GoogleFonts.sarala(
                  //       fontWeight: FontWeight.w600,
                  //       color: kotgGreen,
                  //       fontSize: 8.sp),
                  // ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: EdgeInsets.only(
                        left: 15.sp,
                        top: 18,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Skeleton(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              style: SkeletonStyle.box),
                        );
                      })),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Watch",
                    style: GoogleFonts.sarala(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12.sp),
                  ),
                  // Text(
                  //   "See More",
                  //   style: GoogleFonts.sarala(
                  //       fontWeight: FontWeight.w600,
                  //       color: kotgGreen,
                  //       fontSize: 8.sp),
                  // ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: EdgeInsets.only(
                      left: 15.sp,
                      top: 18,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Skeleton(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          style: SkeletonStyle.box,
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.sp,
                right: 15.sp,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Listen",
                    style: GoogleFonts.sarala(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12.sp),
                  ),
                  // Text(
                  //   "See More",
                  //   style: GoogleFonts.sarala(
                  //       fontWeight: FontWeight.w600,
                  //       color: kotgGreen,
                  //       fontSize: 8.sp),
                  // ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: EdgeInsets.only(
                        left: 15.sp,
                        top: 18,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Skeleton(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              style: SkeletonStyle.box),
                        );
                      })),
            ),
          ]))
        ],
      ),
    ));
  }
}
