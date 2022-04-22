// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/exception/auth_exceptions.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/events/graphql/events_queries.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:http/http.dart' as http;

class InviteRepository {
  final user = Hive.box<User>('user');

  final tokens = Hive.box<Token>('token');

  Future<void> acceptInvite({
    required String inviteID,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/invite/accept/${inviteID}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );

      // Decode the json response
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
        throw Exception('Network Error');
      }

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> declineInvite({
    required String inviteID,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/invite/decline/${inviteID}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );

      // Decode the json response
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
        throw Exception('Network Error');
      }

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future sendInvite({
    required String inviteCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/team/join/${inviteCode}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );
      // Decode the json response
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
        throw Exception('Network Error');
      }

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }
}
