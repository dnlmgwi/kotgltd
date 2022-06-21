import 'package:kotgltd/packages/dependencies.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class EventsPageSkeletonWidget extends StatelessWidget {
  const EventsPageSkeletonWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        controller: scrollController,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 70,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Skeleton(
                            height: 12, width: 24, style: SkeletonStyle.text),
                        subtitle: Skeleton(
                            height: 12, width: 15, style: SkeletonStyle.text),
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
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          );
        });
  }
}
