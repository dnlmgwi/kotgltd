import 'package:animate_do/animate_do.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:ticket_material/ticket_material.dart';

class TicketPageSkeletonWidget extends StatelessWidget {
  const TicketPageSkeletonWidget({
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
          Widget _buildLeft() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Skeleton(
                          height: 12, width: 50.sp, style: SkeletonStyle.text)
                    ],
                  ),
                  SizedBox(height: 12.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Skeleton(
                          height: 12.sp,
                          width: 100.sp,
                          style: SkeletonStyle.text),
                      Skeleton(
                          height: 12.sp,
                          width: 50.sp,
                          style: SkeletonStyle.text)
                    ],
                  ),
                ],
              ),
            );
          }

          Widget _buildRight() {
            return Container(
              child: Center(
                child:
                    Skeleton(height: 50, width: 50, style: SkeletonStyle.box),
              ),
            );
          }

          return FadeIn(
            delay: Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TicketMaterial(
                height: 150,
                colorBackground: Colors.transparent,
                leftChild: _buildLeft(),
                rightChild: _buildRight(),
              ),
            ),
          );
        });
  }
}
