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
      $gender: ENUM_USERSPERMISSIONSUSER_GENDER!
      $date_of_birth: Date!
      $user: ID!
      ) {
        updateUsersPermissionsUser(
          data: {
            first_name: $first_name
            last_name: $last_name
            date_of_birth: $date_of_birth
            gender: $gender
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
              gender
              username
              email
              createdAt
            }
          }
        }
      }''';
  }

  static String updatePhoneNumber() {
    return r'''mutation(
      $phone_number: String!
      $iso_code: String!
      $user: ID!
      ) {
        updateUsersPermissionsUser(
          data: {
            phone_number: $phone_number
            iso_code: $iso_code
          }
          id: $user
        ) {
          data {
            id
            attributes {
              iso_code
              phone_number
            }
          }
        }
      }''';
  }

  static String updateBirthday() {
    return r'''mutation(
      $date_of_birth: Date!
      $user: ID!
      ) {
        updateUsersPermissionsUser(
          data: {
            date_of_birth: $date_of_birth
          }
          id: $user
        ) {
          data {
            id
            attributes {
              date_of_birth
            }
          }
        }
      }''';
  }

  static String updateGender() {
    return r'''mutation(
      $gender: ENUM_USERSPERMISSIONSUSER_GENDER!
      $user: ID!
      ) {
        updateUsersPermissionsUser(
          data: {
            gender: $gender
          }
          id: $user
        ) {
          data {
            id
            attributes {
              gender
            }
          }
        }
      }''';
  }

  static String updateName() {
    return r'''mutation(
      $first_name: String!
      $last_name: String!
      $user: ID!
      ) {
        updateUsersPermissionsUser(
          data: {
            first_name: $first_name
            last_name: $last_name
          }
          id: $user
        ) {
          data {
            id
            attributes {
              first_name
              last_name
            }
          }
        }
      }''';
  }

  static String updateIGN() {
    return r'''mutation($ign: String!, $ticketId: ID!) {
      updateEventRegistration(data: { ign: $ign }, id: $ticketId) {
        data {
          id
          attributes {
            ign
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
            gender
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
