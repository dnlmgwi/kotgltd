// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/exception/auth_exceptions.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/events/graphql/events_queries.dart';
import 'package:kotgltd/features/events/model/kotgEvent.dart';
// ignore: unused_import
import 'package:kotgltd/features/events/model/kotgEvents.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:http/http.dart' as http;

class EventsRepository {
  final user = Hive.box<User>('user');
  static final HttpLink httpLink = HttpLink(
    Env.baseUrl + '/graphql',
  );

  final tokens = Hive.box<Token>('token');
  // Pick an image
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

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

  Future<KOTGEvent> fetchEvents() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(EventsQueries.getAllEvents()),
      );
      final QueryResult? result = await graphQLClient().query(options).timeout(
            Duration(seconds: 30),
          );

      if (result!.hasException) {
        throw NoConnectionException(
            result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!;

      return KOTGEvent.fromJson(response);
    } on TimeoutException {
      ///30 Seconds Timeout
      throw NoConnectionException();
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> registeredEvents({required int eventID}) async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(EventsQueries.registeredEvents()),
          variables: {"user_id": _user!.id, "event_id": eventID});
      final QueryResult? result = await graphQLClient().query(options).timeout(
            Duration(seconds: 30),
          );
      if (result!.hasException) {
        throw NoConnectionException(
            result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['eventRegistrations']['data'];

      return response;
    } on TimeoutException {
      ///30 Seconds Timeout
      throw NoConnectionException();
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> ticketDetails({required int eventId}) async {
    User? _user = user.getAt(0);
    try {
      final QueryOptions options = QueryOptions(
          document: gql(EventsQueries.eventTicket()),
          variables: {"user_id": _user!.id, "event_id": eventId});
      final QueryResult? result = await graphQLClient().query(options).timeout(
            Duration(seconds: 30),
          );
      if (result!.hasException) {
        throw NoConnectionException(
            result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['eventRegistrations']['data'];

      return response;
    } on TimeoutException {
      ///30 Seconds Timeout
      throw NoConnectionException();
    } catch (e) {
      rethrow;
    }
  }

  Future<List> userEvents() async {
    try {
      final response = await http.get(
        Uri.parse('${Env.baseUrl}/api/user/events'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 403) {
        throw Exception('Forbidden');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonDecode(response.body)['error']['message']);
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      // Decode the json response
      final jsonResponse = json.decode(response.body);

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future ticketPay({required String reference}) async {
    try {
      final response =
          await http.post(Uri.parse('${Env.baseUrl}/api/v1/mpamba/pay'),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
                'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
              },
              body: jsonEncode({
                "msisdn": "265880649774", //TODO Get Number From User
                "tran_id": reference,
              }));
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 403) {
        throw Exception('Forbidden');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonDecode(response.body)['error']['message']);
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      // Decode the json response
      final jsonResponse = json.decode(response.body);

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deregisterEvent({
    required int eventID,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/event/deregister/${eventID}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonDecode(response.body)['error']['message']);
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future registerEvent({
    required String eventID,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.baseUrl}/api/event/register/${eventID}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer ${tokens.get(0)!.jwt}'
        },
      );

      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 400) {
        throw Exception(jsonDecode(response.body)['error']['message']);
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception('Network Error');
      }

      // Decode the json response
      final jsonResponse = json.decode(response.body);

      return jsonResponse['data'];
    } catch (e) {
      rethrow;
    }
  }
}
