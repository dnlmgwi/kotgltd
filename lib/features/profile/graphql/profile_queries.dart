class ProfileQueries {
  // static String uploadProfilePicture() {
  //   return r'''mutation($file: Upload!) {
  //     upload (file: $file){
  //       id
  //     }
  //   }''';
  // }

  static String updateProfile() {
    return r'''mutation(
      $first_name: String!
      $last_name: String!
      $phone_number: String!
      $iso_code: String!
      $date_of_birth: Date!
      $user: ID!
      ) {
        updateUsersPermissionsUser(
          data: {
            first_name: $first_name
            last_name: $last_name
            date_of_birth: $date_of_birth
            iso_code: $iso_code
            phone_number: $phone_number
          }
          id: $user
        ) {
          data {
            id
            attributes {
              first_name
              last_name
              date_of_birth
              iso_code
              phone_number
              username
              email
              createdAt
            }
          }
        }
      }''';
  }

  static String getProfile() {
    return r'''query ($user_id: ID!) {
      usersPermissionsUser(id:$user_id){
        data{
          id
          attributes {
            username
            email
            first_name
            last_name
            date_of_birth
            phone_number
            iso_code
            createdAt
      }
    }
  }
}''';
  }

  static String getAvatars() {
    return r'''query {
      avatars {
        id
        image {
          url
        }
      }
    }''';
  }
}
