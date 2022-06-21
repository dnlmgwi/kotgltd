// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/exception/auth_exceptions.dart';
import 'package:kotgltd/features/auth/exception/input_exception.dart';
import 'package:kotgltd/features/auth/interfaces/i_profile_repository.dart';
// import 'package:kotgltd/features/auth/model/profile.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/profile/graphql/profile_queries.dart';
import 'package:kotgltd/features/profile/model/profile.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:phone_form_field/phone_form_field.dart';

class ProfileRepository extends IProfileRepository {
  final user = Hive.box<User>('user');

  static final HttpLink httpLink = HttpLink(
    Env.baseUrl + '/graphql',
  );

  final tokens = Hive.box<Token>('token');
  // final profile = Hive.box<Profile>('profile');
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

  @override
  Future updateProfile({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
  }) async {
    User? _user = user.values.first;

    // if (phoneNumber.nsn.isEmpty) {
    //   throw InvalidPhoneNumberException();
    // }

    // if (phoneNumber.isoCode != IsoCode.MW) {
    //   throw InvalidNumberAreaException();
    // }

    try {
      final MutationOptions options = MutationOptions(
          document: gql(ProfileQueries.updateProfile()),
          variables: {
            "user": _user.id,
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            // "phone_number": phoneNumber.nsn, //TODO Fix Phone Number
            // "iso_code": phoneNumber.isoCode.name,
            "date_of_birth": dateOfBirth
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['updateUsersPermissionsUser']['data'];

      return Profile.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Profile> getProfile() async {
    User? _user = user.values.first;
    try {
      final QueryOptions options =
          QueryOptions(document: gql(ProfileQueries.getProfile()), variables: {
        "user_id": _user.id,
      });

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['usersPermissionsUser']['data'];

      return Profile.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
