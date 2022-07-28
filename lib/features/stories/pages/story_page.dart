import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/stories/providers/stories_providers.dart';
import 'package:kotgltd/features/transactions/widgets/transactions_page_skeleton.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
// import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html2md/html2md.dart' as html2md;

class StoryPage extends ConsumerWidget {
  StoryPage({Key? key, required this.id, required this.slug}) : super(key: key);

  final String id, slug;

  final scrollController = ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context, ref) {
    Future<void> _refreshEvents(String id) async {
      return ref.refresh(postProvider(id));
    }

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
            title: AutoSizeText(
              slug,
              maxLines: 1,
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
                  onRefresh: () => _refreshEvents(id),
                  child: Consumer(builder: (context, ref, _) {
                    final _post = ref.watch(postProvider(id));

                    return _post.map(
                        data: (post) {
                          if (post.value.isEmpty) {
                            //print('project snapshot data is: ${projectSnap.data}');
                            return Center(
                              child: Text("We couldn't this post"),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    timeago.format(
                                        DateTime.parse(post.value['date'])),
                                    style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.grey)),
                                MarkdownBody(
                                  shrinkWrap: true,
                                  data: Markdown(
                                          data: html2md.convert(post
                                              .value['content']['rendered']))
                                      .data,
                                ),
                              ],
                            ),
                          );
                        },
                        error: (error) {
                          return Column(
                            children: [
                              Text('Network Error'),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 5,
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 70,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: ListTile(
                                                    title: Skeleton(
                                                        height: 12,
                                                        width: 24,
                                                        style:
                                                            SkeletonStyle.text),
                                                    subtitle: Skeleton(
                                                        height: 12,
                                                        width: 15,
                                                        style:
                                                            SkeletonStyle.text),
                                                    trailing: Skeleton(
                                                      height: 30,
                                                      width: 65,
                                                      style: SkeletonStyle.text,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          );
                        },
                        loading: (loading) => TransactionPageSkeletonWidget(
                              scrollController: scrollController,
                            ));
                  }),
                ),
              ),
            ],
          )),
    );
  }
}
