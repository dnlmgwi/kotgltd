// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/exception/auth_exceptions.dart';
import 'package:kotgltd/features/auth/model/profile.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/profile/graphql/profile_queries.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';

class ProfileRepository {
  final user = Hive.box<User>('user');

  static final HttpLink httpLink = HttpLink(
    Env.baseUrl + '/graphql',
  );

  final tokens = Hive.box<Token>('token');
  final profile = Hive.box<Profile>('profile');
  // Pick an image
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(partialDataPolicy: PartialDataCachePolicy.accept),
    link: httpLink,
  );

  GraphQLClient graphQLClient() {
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${tokens.get(0)!.jwt}',
    );

    final Link link = authLink.concat(httpLink);

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    return client;
  }

  Future createProfile({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required PhoneNumber phoneNumber,
    required String avatarId,
    // required String userId,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dob = formatter.format(dateOfBirth);
    User? _user = user.values.first;

    try {
      final MutationOptions options = MutationOptions(
          document: gql(ProfileQueries.createProfile()),
          variables: {
            "first_name": firstName,
            "last_name": lastName,
            "date_of_birth": dob,
            "user": _user.id,
            "iso_code": phoneNumber.isoCode,
            "phone_number": phoneNumber.nsn,
            "avatar_id": avatarId
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['createProfile'];

      profile.put(0, Profile.fromJson(response['profile']));

      print(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future editProfile({
    required String avatarId,
    // required String userId,
  }) async {
    User? _user = user.values.first;

    try {
      final MutationOptions options = MutationOptions(
          document: gql(ProfileQueries.editProfile()),
          variables: {
            "user": _user.id,
            "avatar_id": avatarId,
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['updateProfile'];

      profile.put(0, Profile.fromJson(response['profile']));

      print(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<Profile> getProfile() async {
  //   User? _user = user.values.first;
  //   try {
  //     final QueryOptions options =
  //         QueryOptions(document: gql(ProfileQueries.getProfile()), variables: {
  //       "user_id": _user.id,
  //     });

  //     final QueryResult? result = await graphQLClient().query(options);

  //     if (result!.hasException) {
  //       print(result.exception.toString());
  //       throw Exception(result.exception!.graphqlErrors.first.message);
  //     }

  //     var response = result.data!['user'];

  //     if (response['profile'] == null) {
  //       throw NoProfileException(); //TODO User has No Profile
  //     }

  //     return Profile.fromJson(response['profile']);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List> getAvatars() async {
  //   try {
  //     final QueryOptions options = QueryOptions(
  //       document: gql(ProfileQueries.getAvatars()),
  //     );
  //     final QueryResult? result = await graphQLClient().query(options);

  //     if (result!.hasException) {
  //       print(result.exception.toString());
  //       throw Exception(result.exception!.graphqlErrors.first.message);
  //     }

  //     var response = result.data!['avatars'];

  //     print(response);

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
