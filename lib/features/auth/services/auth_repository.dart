// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/features/auth/GraphQL/auth_queries.dart';
import 'package:kotgltd/features/auth/exception/auth_exceptions.dart';
import 'package:kotgltd/features/auth/exception/input_exception.dart';
import 'package:kotgltd/features/auth/interfaces/i_auth_repository.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/models.dart';

class AuthRepository extends IAuthRepository {
  static final HttpLink httpLink = HttpLink(
    Env.baseUrl + '/graphql',
  );

  //Create Singleton
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(partialDataPolicy: PartialDataCachePolicy.accept),
    link: httpLink,
  );

  @override
  Future<LoginResponse?> signIn({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      throw InvalidEmailException();
    }

    if (password.isEmpty) {
      throw InvalidPasswordException();
    }

    try {
      final MutationOptions options = MutationOptions(
          document: gql(AuthQueries.signIn()),
          variables: {'identifier': email, 'password': password});

      final QueryResult? result = await client.mutate(options).timeout(
            Duration(seconds: 30),
          );

      if (result!.hasException) {
        throw NoConnectionException(
            result.exception!.graphqlErrors.first.message);
      }

      return LoginResponse.fromJson(result.data!);
    } on TimeoutException {
      ///30 Seconds Timeout
      throw NoConnectionException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    if (email.isEmpty) {
      throw InvalidEmailException();
    }

    try {
      final MutationOptions options = MutationOptions(
          document: gql(AuthQueries.forgotPassword()),
          variables: {'identifier': email});

      final QueryResult? result = await client.mutate(options).timeout(
            Duration(seconds: 30),
          );

      if (result!.hasException) {
        throw NoConnectionException(
            result.exception!.graphqlErrors.first.message);
      }
    } on TimeoutException {
      ///30 Seconds Timeout
      throw NoConnectionException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegisterResponse?> signUp({
    required String username,
    required String email,
    required String password,
    // required PhoneNumber phoneNumber,
  }) async {
    if (email.isEmpty) {
      throw InvalidEmailException();
    }

    if (username.isEmpty) {
      throw InvalidUsernameException();
    }

    if (password.isEmpty) {
      throw InvalidPasswordException();
    }

    // if (phoneNumber.toString().isEmpty) {
    //   throw InvalidPasswordException();
    // }

    try {
      final MutationOptions options =
          MutationOptions(document: gql(AuthQueries.signUp()), variables: {
        'email': email,
        'password': password,
        'username': username,
      });

      final QueryResult? result = await client.mutate(options).timeout(
            Duration(seconds: 30),
          );

      if (result!.hasException) {
        throw AuthError(result.exception!.graphqlErrors.first.message);
      }

      return RegisterResponse.fromJson(result.data!);
    } on TimeoutException {
      ///30 Seconds Timeout
      throw NoConnectionException();
    } catch (e) {
      rethrow;
    }
  }
}
