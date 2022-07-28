import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/components.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/stories/providers/stories_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html2md/html2md.dart' as html2md;

class StoriesPage extends ConsumerWidget {
  StoriesPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    Future<void> _refreshStories() async {
      return ref.refresh(storiesRepoProvider);
    }

    return LoaderOverlay(
        overlayOpacity: 0.8,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: kotgBlack,
                leading: IconButton(
                  icon: Icon(Ionicons.chevron_back, color: kotgGreen),
                  onPressed: () {
                    context.pop();
                  },
                ),
                title: Text(
                  'Stories',
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
                  Divider(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _refreshStories(),
                      child: Consumer(builder: (context, ref, _) {
                        final _eventsRepo = ref.watch(storiesRepoProvider);

                        final _page = ref.watch(pageProvider.state);
                        return FutureBuilder(
                            // Initialize FlutterFire:
                            future: _eventsRepo.fetchPosts(),
                            builder: (context, snapshot) {
                              // Check for errors
                              if (snapshot.hasError) {
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
                                            child: Text(
                                                snapshot.error.toString(),
                                                style: GoogleFonts.sarala(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10.sp,
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ));
                              }
                              // Once complete, show your application
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                var posts = snapshot.data as List;

                                if (posts.isEmpty) {
                                  //print('project snapshot data is: ${projectSnap.data}');
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          top: 35.sp,
                                          left: 15.sp,
                                          bottom: 35.sp),
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
                                              _refreshStories();
                                            },
                                          ),
                                        ),
                                      ));
                                }

                                return ListView.builder(
                                    itemCount: posts.length,
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
                                                    '/stories/post?id=${posts[index]['id']}&slug=${posts[index]['title']['rendered']}'),
                                                highlightColor: kotgBlack,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: ListTile(
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AutoSizeText(
                                                              MarkdownBody(
                                                                shrinkWrap:
                                                                    true,
                                                                data: Markdown(
                                                                        data: html2md.convert(posts[index]['excerpt']
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
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey)),
                                                          Text(
                                                              timeago.format(DateTime
                                                                  .parse(posts[
                                                                          index]
                                                                      [
                                                                      'date'])),
                                                              style: GoogleFonts.sarala(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey))
                                                        ],
                                                      ),
                                                      title: AutoSizeText(
                                                          posts[index]['title']
                                                              ['rendered'],
                                                          wrapWords: true,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: GoogleFonts
                                                              .sarala(
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
                              }
                              // Otherwise, show something whilst waiting for initialization to complete
                              return Container(
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
                              );
                            });
                      }),
                    ),
                  ),
                ],
              )),
        ));
  }
}
