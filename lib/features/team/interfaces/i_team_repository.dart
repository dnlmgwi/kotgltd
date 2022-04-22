import 'package:kotgltd/features/team/model/team.dart';

abstract class ITeamRepository {
  Future createTeam({
    required String teamName,
  });

  Future deleteTeam();

  Future leaveTeam();

  Future<Team> getTeam();

  Future<List?> getJoinRequests({required String inviteCode});

  Future<num> getInviteCount({required String inviteCode});
}
