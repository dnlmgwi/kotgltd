import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required String this.url,
    required String this.name,
  }) : super(key: key);

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    //image size fill
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Skeleton(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  style: SkeletonStyle
                      .box), // you can add pre loader iamge as well to show loading.
              //show progress  while loading image
              errorWidget: (context, url, error) => Center(
                child: Icon(
                  LineIcons.imageFile,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style: GoogleFonts.oxygen(
                fontWeight: FontWeight.normal,
                fontSize: 10.sp,
                color: Colors.white70,
              ),
            ),
          )
        ],
      ),
    );
  }
}
