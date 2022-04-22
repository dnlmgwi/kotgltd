// import 'package:supabase/supabase.dart';
import 'dart:io';

import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/team/graphql/team_queries.dart';
import 'package:kotgltd/features/team/interfaces/i_team_repository.dart';
import 'package:kotgltd/features/team/model/team.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:http/http.dart' as http;
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
  Future<Team> getTeam() async {
    try {
      final response = await http.get(
        Uri.parse('${Env.baseUrl}/api/team'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      return Team.fromJson(jsonResponse['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future leaveTeam() async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/team/leave'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future createTeam({
    required String teamName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/team/create/${teamName}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List?> getMyCreatedTeamMembers() async {
  //   User? _user = user.getAt(0);
  //   try {
  //     final QueryOptions options = QueryOptions(
  //         document: gql(TeamQueries.getMyCreatedTeam()),
  //         variables: {"captain_id": _user!.id}); //TODO Variable

  //     final QueryResult? result = await graphQLClient().query(options);

  //     if (result!.hasException) {
  //       print(result.exception.toString());
  //       throw Exception(result.exception!.graphqlErrors.first.message);
  //     }

  //     var response = result.data!['teams'] as List?;

  //     print(response);

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

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

      var response = result.data!['invites']['data'] as List;

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<num> getInviteCount({required String inviteCode}) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.fetchTeamJoinRequestsCount()),
          variables: {"invite_code": inviteCode}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['invites']['meta']['pagination']['total'];

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTeam({required int teamId}) async {
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TeamQueries.deleteTeam()),
          variables: {"team_id": teamId}); //TODO Variable

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['invites'];

      print(response);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<String> createTeam({
  //   required String teamName,
  // }) async {
  //   User? _user = user.getAt(0);
  //   try {
  //     final QueryOptions options = QueryOptions(
  //         document: gql(
  //           TeamQueries.createTeam(),
  //         ),
  //         variables: {
  //           "team_name": teamName,
  //           "captain": _user!.id,
  //         });
  //     final QueryResult? result = await graphQLClient().query(options);

  //     if (result!.hasException) {
  //       throw Exception(result.exception!.graphqlErrors.first.message);
  //     }

  //     var response = result.data!['createTeam']['team']['team_name'];

  //     print(response);

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
