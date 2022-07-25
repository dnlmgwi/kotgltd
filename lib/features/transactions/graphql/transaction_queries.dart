class TransactionQueries {
  static String myTransactions() {
    return r'''
          query($user_id: ID!) {
            payments(filters: { user: { id: { eq: $user_id } } },pagination:{limit:10}) {
              data {
                id
                attributes {
                  createdAt
                  result_desc
                  conversation_id
                }
              }
            }
          }
        ''';
  }
}
