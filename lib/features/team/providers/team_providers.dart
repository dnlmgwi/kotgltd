import 'package:kotgltd/features/team/services/invite_repository.dart';
import 'package:kotgltd/features/team/services/join_code_generator.dart';
import 'package:kotgltd/features/team/services/team_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';

final teamNameProvider = StateProvider<String>((ref) => '');

final inviteCodeGenerator = Provider((ref) => InviteCodeGenerator());

enum TeamState { member, captain, none }

final teamStateProvider = StateProvider.autoDispose((ref) => TeamState.none);

final teamStateFutureProvider = FutureProvider.autoDispose((ref) async {
  var teamStateType = ref.watch(teamStateProvider);
  final team = await ref.watch(teamRepoProvider).getTeam();
  return team;
});

final teamRepoProvider = Provider(
  (ref) => TeamRepository(),
);

final inviteRepoProvider = Provider(
  (ref) => InviteRepository(),
);
