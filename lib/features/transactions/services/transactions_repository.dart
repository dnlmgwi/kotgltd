// import 'package:supabase/supabase.dart';
import 'package:graphql/client.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
// import 'package:kotgltd/features/auth/model/profile.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/transactions/graphql/transaction_queries.dart';
import 'package:kotgltd/features/transactions/interfaces/i_transaction_repository.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';

class TransactionRepository extends ITransactionsRepository {
  final user = Hive.box<User>('user');

  static final HttpLink httpLink = HttpLink(
    Env.baseUrl + '/graphql',
  );

  final tokens = Hive.box<Token>('token');

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
  Future myTransactions() async {
    User? _user = user.values.first;
    try {
      final QueryOptions options = QueryOptions(
          document: gql(TransactionQueries.myTransactions()),
          variables: {
            "user_id": _user.id,
          });

      final QueryResult? result = await graphQLClient().query(options);

      if (result!.hasException) {
        throw Exception(result.exception!.graphqlErrors.first.message);
      }

      var response = result.data!['payments']['data'];

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
