import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/auth/providers/auth_state.dart';
import 'package:kotgltd/packages/dependencies.dart';

class AuthStateWidget extends ConsumerWidget {
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder signedOutBuilder;
  // final WidgetBuilder noProfileBuilder;
  // final WidgetBuilder returningBuilder;

  AuthStateWidget({
    required this.signedInBuilder,
    required this.signedOutBuilder,
    // required this.noProfileBuilder,
  });

  @override
  Widget build(BuildContext context, ref) {
    final userAuthState = ref.watch(authStateProvider);
    return userAuthState.map(
      data: (authState) {
        if (authState.value == AuthState.isAuth) {
          return signedInBuilder(context);
        } else if (authState.value == AuthState.isNotAuth) {
          return signedOutBuilder(context);
        }
        // else if (authState.value == AuthState.noProfile) {
        //   return noProfileBuilder(context);
        // }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Your are offline'),
                const Text('Can\'t load data right now.'),
              ],
            ),
          ),
        );
      },
      loading: (loading) =>
          Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Something went wrong'),
              const Text('Can\'t load data right now.'),
            ],
          ),
        ),
      ),
    );
  }
}
