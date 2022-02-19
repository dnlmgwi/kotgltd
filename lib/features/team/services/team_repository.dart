// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/team/graphql/team_queries.dart';
import 'package:kotgltd/features/team/interfaces/i_team_repository.dart';
import 'package:kotgltd/features/team/model/team.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

class TeamRepository extends ITeamRepository {
  static final HttpLink httpLink = HttpLink(
    Env.baseUrl + '/graphql',
  );

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  final user = Hive.box<User>('user');
  final team = Hive.box<Team>('team');
  final tokens = Hive.box<Token>('token');

  GraphQLClient graphQLClient() {
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${tokens.get(0)!.jwt}',
    );

    final Link link = authLink.concat(httpLink);

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(partialDataPolicy: PartialDataCachePolicy.accept),
      link: link,
    );

    return client;
  }

  @override
  Future<List?> getMyCreatedTeamMembers() async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.getMyCreatedTeam()),
          variables: {"captain_id": _user!.id}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teams'] as List?;

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List?> getJoinedTeam() async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.getJoinedTeam()),
          variables: {"member_id": _user!.id}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teamJoinRequests'] as List;

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List?> getMyCreatedTeam() async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.getMyCreatedTeam()),
          variables: {"captain_id": _user!.id}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teams'];

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List?> getJoinRequests({required String inviteCode}) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.fetchTeamJoinRequests()),
          variables: {"invite_code": inviteCode});

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teamJoinRequests'] as List;

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<num> getJoinRequestsCount({required String inviteCode}) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.fetchTeamJoinRequestsCount()),
          variables: {"invite_code": inviteCode}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response =
          result.data!['teamJoinRequestsConnection']['aggregate']['count'];

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List?> deleteTeamJoinRequests({required String id}) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.deleteTeamJoinRequests()),
          variables: {"request_id": id}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teamJoinRequests'];

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTeam({required String teamId}) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.deleteTeam()),
          variables: {"team_id": teamId}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teamJoinRequests'];

      print(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createJoinRequest({
    required String inviteCode,
  }) async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.createJoinRequest()),
          variables: {"invite_code": inviteCode, "member_id": _user!.id});
      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response =
          result.data!['createTeamJoinRequest']['teamJoinRequest']['id'];

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> claimJoinRequest({
    required String id,
    required String teamId,
  }) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.claimJoinRequest()),
          variables: {"request_id": id, "team_id": teamId});

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['teamJoinRequests'];

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createTeam({
    required String teamName,
    required String inviteCode,
  }) async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(
            TeamQueries.createTeam(),
          ),
          variables: {
            "team_name": teamName,
            "invite_code": inviteCode,
            "captain": _user!.id,
          });
      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['createTeam']['team']['team_name'];

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
