class AuthQueries {
  static String getMe() {
    return r'''query {
      me {
        id
        username
        email
      }
    }''';
  }

  static String signIn() {
    return r'''mutation ($identifier: String!, $password: String!) {
      login(input: { identifier: $identifier, password: $password }) {
        jwt
        user {
          id
          username
          email       
        }
      }
    }''';
  }

  static String signUp() {
    return r'''mutation ($email: String!, $password: String!, $username: String!) {
      register(input: { username: $username, email: $email, password: $password }) {
        jwt
        user {
          id
          username
          email
        }
      }
    }''';
  }

  static String forgotPassword() {
    return r'''mutation ($identifier: String!) {
      forgotPassword( email: $identifier) {
       ok
      }
    }''';
  }
}
