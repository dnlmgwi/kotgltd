import 'package:kotgltd/features/team/model/invitesData.dart';
import 'package:kotgltd/features/team/model/team.dart';
import 'package:kotgltd/features/team/model/userEntity.dart';

abstract class ITeamRepository {
  Future createTeam({
    required String teamName,
  });

  Future deleteTeam();

  Future leaveTeam();

  Future<Team> getTeam();

  Future<List<InviteEntity>> getInvites({required String inviteCode});

  Future<num> getInviteCount({required String inviteCode});
}
