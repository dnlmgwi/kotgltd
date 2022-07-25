import 'package:animate_do/animate_do.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:ticket_material/ticket_material.dart';

class TransactionPageSkeletonWidget extends StatelessWidget {
  const TransactionPageSkeletonWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        controller: scrollController,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (BuildContext context, int index) {
          return FadeIn(
            delay: Duration(milliseconds: 500),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Skeleton(height: 50.sp),
              ),
            ),
          );
        });
  }
}
