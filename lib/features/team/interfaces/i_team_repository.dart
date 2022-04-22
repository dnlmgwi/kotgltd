import 'package:kotgltd/features/team/model/team.dart';

abstract class ITeamRepository {
  Future createTeam({
    required String teamName,
  });

  Future leaveTeam();

  Future<Team> getTeam();

  Future<List?> getJoinRequests({required String inviteCode});

  Future<num> getInviteCount({required String inviteCode});

  Future<void> deleteTeam({required int teamId});
}
