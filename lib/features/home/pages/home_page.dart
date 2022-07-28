import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/Tickets/pages/tickets_page.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/stories/providers/stories_providers.dart';
// import 'package:kotgltd/features/reminder/providers/reminder_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html2md/html2md.dart' as html2md;

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, ref) {
    final _user = ref.watch(currentUserProvider);
    // final _page = ref.watch(pageProvider.state);
    // final _reminder = ref.watch(addRemiderProvider);

    Future<void> _refreshFeed() async {
      return ref.refresh(eventsRepoProvider);
    }

    Future<void> _refreshPosts() async {
      return ref.refresh(storiesRepoProvider);
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
                          onTap: () => context.push('/profile'),
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
                onTap: () => context.push('/tickets'),
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
            child: Column(
              children: [
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
                  padding:
                      EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Stories",
                        style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 12.sp),
                      ),
                      TextButton(
                        child: Text(
                          "See More",
                          style: GoogleFonts.sarala(
                              fontWeight: FontWeight.w600,
                              color: kotgGreen,
                              fontSize: 8.sp),
                        ),
                        onPressed: () => context.push('/stories'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 200,
                    child: RefreshIndicator(
                      onRefresh: () => _refreshPosts(),
                      child: Consumer(builder: (context, ref, _) {
                        final _eventsRepo = ref.watch(postsProvider);

                        return _eventsRepo.map(
                            error: (error) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.sp,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 35.sp,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 35, left: 35, bottom: 5),
                                          child: Text(error.toString(),
                                              style: GoogleFonts.sarala(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 10.sp,
                                                  color: Colors.grey)),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            data: (posts) {
                              if (posts.value.isEmpty) {
                                //print('project snapshot data is: ${projectSnap.data}');
                                return Padding(
                                    padding: EdgeInsets.only(
                                        top: 35.sp, left: 15.sp, bottom: 35.sp),
                                    child: Center(
                                      child: Container(
                                        width: 50.w,
                                        child: ElevatedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
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
                                            _refreshPosts();
                                          },
                                        ),
                                      ),
                                    ));
                              }

                              return ListView.builder(
                                  itemCount: posts.value.length,
                                  controller: scrollController,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FadeIn(
                                        delay: Duration(milliseconds: 500),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.sp, right: 15.sp),
                                          child: Card(
                                            elevation: 1,
                                            child: InkWell(
                                              onTap: () => context.push(
                                                  '/stories/post?id=${posts.value[index]['id']}&slug=${posts.value[index]['title']['rendered']}'),
                                              highlightColor: kotgBlack,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: ListTile(
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AutoSizeText(
                                                            MarkdownBody(
                                                              shrinkWrap: true,
                                                              data: Markdown(
                                                                      data: html2md.convert(posts.value[index]
                                                                              [
                                                                              'excerpt']
                                                                          [
                                                                          'rendered']))
                                                                  .data,
                                                            ).data,
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: GoogleFonts.sarala(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .grey)),
                                                        Text(
                                                            timeago.format(
                                                                DateTime.parse(
                                                                    posts.value[
                                                                            index]
                                                                        [
                                                                        'date'])),
                                                            style: GoogleFonts.sarala(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .grey))
                                                      ],
                                                    ),
                                                    title: AutoSizeText(
                                                        posts.value[index]
                                                                ['title']
                                                            ['rendered'],
                                                        wrapWords: true,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style:
                                                            GoogleFonts.sarala(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10.sp,
                                                          color: Colors.white,
                                                        ))),
                                              ),
                                            ),
                                          ),
                                        ));
                                  });
                            },
                            loading: ((loading) =>
                                // Otherwise, show something whilst waiting for initialization to complete
                                Container(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 15.sp, top: 18, right: 15.sp),
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Skeleton(
                                            height: 150.sp,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            style: SkeletonStyle.box,
                                          ),
                                        );
                                      }),
                                )));
                      }),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
