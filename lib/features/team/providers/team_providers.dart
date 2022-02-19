import 'package:kotgltd/features/team/services/join_code_generator.dart';
import 'package:kotgltd/features/team/services/team_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';

final teamNameProvider = StateProvider<String>((ref) => '');

final inviteCodeGenerator = Provider((ref) => InviteCodeGenerator());

final inviteCodeProvider = FutureProvider.autoDispose<String>((ref) async {
  var teamName = ref.watch(teamNameProvider);
  return ref.read(inviteCodeGenerator).createInviteCode(teamName);
});

enum TeamState { member, captain, none }

final teamStateProvider = StateProvider.autoDispose((ref) => TeamState.none);

final teamStateFutureProvider = FutureProvider.autoDispose<List>((ref) async {
  var teamStateType = ref.watch(teamStateProvider);
  final teamJoined = await ref.watch(teamRepoProvider).getJoinedTeam();
  final teamCreated = await ref.watch(teamRepoProvider).getMyCreatedTeam();
  //if Member & Captain is Empty
  if (teamCreated!.isEmpty && teamJoined!.isEmpty) {
    teamStateType = TeamState.none;
    return [];
  } else if (teamJoined!.isNotEmpty) {
    teamStateType = TeamState.member;
    return teamJoined;
  } else if (teamCreated.isNotEmpty) {
    teamStateType = TeamState.captain;
    return teamCreated;
  }
  return [];
});

final teamRepoProvider = Provider(
  (ref) => TeamRepository(),
);
