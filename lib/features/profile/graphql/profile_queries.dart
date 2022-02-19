class ProfileQueries {
  // static String uploadProfilePicture() {
  //   return r'''mutation($file: Upload!) {
  //     upload (file: $file){
  //       id
  //     }
  //   }''';
  // }

  static String createProfile() {
    return r'''mutation($first_name: String!,  $last_name: String!, $phone_number: String!,  $iso_code: String!, $date_of_birth: Date!, $user: ID!, $avatar_id :ID!) {
      createProfile(
        input: {
          data: {
            first_name: $first_name,
            last_name: $last_name,
            date_of_birth: $date_of_birth,
            user: $user,
            iso_code: $iso_code,
            phone_number: $phone_number,
            avatar: $avatar_id
          }}){
          profile {
            id
          }
        }
      }''';
  }

  static String editProfile() {
    return r'''mutation($user: ID!, $avatar_id :ID!) {
  updateProfile(
    input: {
      where: { id: $user }
      data: {
avatar: $avatar_id}
    }
  ) {
   profile {
    avatar {
      id
    }
  }
  }
}''';
  }

  static String getProfile() {
    return r'''query ($user_id: ID!) {
      user(id: $user_id) {
        profile {
          id
          avatar {
            image{
              url
            }
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
