abstract class ITeamRepository {
  Future<String> createTeam({
    required String teamName,
    required String inviteCode,
  });

  Future<List?> getMyCreatedTeamMembers();

  Future<List?> getJoinedTeam();

  Future<List?> getMyCreatedTeam();

  Future<List?> getJoinRequests({required String inviteCode});

  Future<num> getJoinRequestsCount({required String inviteCode});

  Future<List?> deleteTeamJoinRequests({required String id});

  Future<void> deleteTeam({required String teamId});

  Future<void> createJoinRequest({
    required String inviteCode,
  });

  Future<void> claimJoinRequest({
    required String id,
    required String teamId,
  });
}
