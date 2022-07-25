import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/dependencies.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {Key? key}) : super(key: key);
  final Exception error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Page Not Found',
            style: GoogleFonts.sarala(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: kotgGreen,
            ),
          ),
          centerTitle: true,
          backgroundColor: kotgBlack,
          leading: IconButton(
            icon: Icon(Ionicons.chevron_back, color: kotgGreen),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(error.toString()),
              TextButton(
                onPressed: () => context.go('/dashboard'),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      );
}
