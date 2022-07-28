import 'package:kotgltd/packages/dependencies.dart';

class TicketWidget extends ConsumerWidget {
  const TicketWidget({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    this.padding,
    this.margin,
    this.shadow,
    this.color,
    required this.isCornerRounded,
  }) : super(key: key);

  final Widget child;
  final double width, height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;
  final Color? color;
  final bool isCornerRounded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        child: child,
        duration: const Duration(seconds: 1),
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          boxShadow: shadow,
          color: color,
          borderRadius: isCornerRounded
              ? BorderRadius.circular(20.0)
              : BorderRadius.circular(0.0),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
