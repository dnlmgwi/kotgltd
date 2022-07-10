import 'package:kotgltd/features/team/model/invitesData.dart';
import 'package:kotgltd/features/team/model/userEntity.dart';

abstract class ITeamRepository {
  Future createTeam({
    required String teamName,
  });

  Future deleteTeam();

  Future leaveTeam();

  Future<void> deleteMyInvite({
    required String inviteId,
  });

  Future<List<InviteEntity>> getMyInvites();

  Future<Team> getTeam();

  Future<List<InviteEntity>> getInvites({required String inviteCode});

  Future<num> getInviteCount({required String inviteCode});
}
