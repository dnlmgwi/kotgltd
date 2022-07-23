import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/dependencies.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {Key? key}) : super(key: key);
  final Exception error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Page Not Found',
          ),
          backgroundColor: kotgBlack,
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
