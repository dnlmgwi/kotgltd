// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/exception/auth_exceptions.dart';
import 'package:kotgltd/features/auth/exception/input_exception.dart';
import 'package:kotgltd/features/auth/interfaces/i_profile_repository.dart';
// import 'package:kotgltd/features/auth/model/profile.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/events/model/eventRegistrations.dart';
import 'package:kotgltd/features/profile/graphql/profile_queries.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
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
  Future<void> updateName({
    required String firstName,
    required String lastName,
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
          document: gql(ProfileQueries.updateName()),
          variables: {
            "user": _user.id,
            "first_name": firstName,
            "last_name": lastName,
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGender({
    required String gender,
  }) async {
    User? _user = user.values.first;

    if (Gender.None.name == gender) {
      throw SelectGenderException();
    }

    try {
      final MutationOptions options = MutationOptions(
          document: gql(ProfileQueries.updateGender()),
          variables: {
            "user": _user.id,
            "gender": gender,
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }
    } on SelectGenderException catch (e) {
      throw e;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePhoneNumber({
    required PhoneNumber phoneNumber,
  }) async {
    User? _user = user.values.first;

    if (phoneNumber.nsn.isEmpty) {
      throw InvalidPhoneNumberException();
    }

    if (phoneNumber.isoCode != IsoCode.MW) {
      throw InvalidNumberAreaException();
    }

    try {
      final MutationOptions options = MutationOptions(
          document: gql(ProfileQueries.updatePhoneNumber()),
          variables: {
            "user": _user.id,
            "phone_number": phoneNumber.nsn, //TODO Fix Phone Number
            "iso_code": phoneNumber.isoCode.name,
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateDateOfBirth({
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
          document: gql(ProfileQueries.updateBirthday()),
          variables: {
            "user": _user.id,
            "date_of_birth": dateOfBirth,
          });
      final QueryResult? result = await graphQLClient().mutate(options);

      if (result!.hasException) {
        print(result.exception.toString());
        throw Exception(result.exception!.graphqlErrors.first.message);
      }
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

  @override
  Future updateProfile(
      {required String firstName,
      required String lastName,
      required String gender,
      required String dateOfBirth}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
