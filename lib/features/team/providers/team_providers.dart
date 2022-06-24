import 'package:kotgltd/features/team/model/inviteEntity.dart';
import 'package:kotgltd/features/team/services/invite_repository.dart';
import 'package:kotgltd/features/team/services/join_code_generator.dart';
import 'package:kotgltd/features/team/services/team_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';

final teamNameProvider = StateProvider<String>((ref) => '');

final inviteCodeGenerator = Provider((ref) => InviteCodeGenerator());

enum TeamState { member, captain, none }

final teamStateProvider = StateProvider.autoDispose((ref) => TeamState.none);

final teamStateFutureProvider = FutureProvider.autoDispose((ref) async {
  // var teamStateType = ref.watch(teamStateProvider);
  final team;
  try {
    team = await ref.watch(teamRepoProvider).getTeam();
  } catch (e) {
    rethrow;
  }
  return team;
});

final teamInviteStateFutureProvider =
    FutureProvider.family((ref, String inviteCode) async {
  // var teamStateType = ref.watch(teamStateProvider);
  List<InviteEntity> invites;
  try {
    invites =
        await ref.watch(teamRepoProvider).getInvites(inviteCode: inviteCode);
  } catch (e) {
    rethrow;
  }
  return invites;
});

final teamRepoProvider = Provider(
  (ref) => TeamRepository(),
);

final inviteRepoProvider = Provider(
  (ref) => InviteRepository(),
);
