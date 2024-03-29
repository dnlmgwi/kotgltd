class EventsQueries {
  static String getAllEvents() {
    return r'''query {
  events(
    sort: "event_date:asc", publicationState:LIVE,
  ){
    data {
      id
      attributes {
        name
        event_date
        event_time
        image {
         data {
          attributes {
            url
          }
        }
        }
        max_participants
        description
        price
        prize
        game {
          data {
          attributes {
              name
            }
          }
        }
      }
    }
  }
}''';
  }

  //TODO Update IGN
  //   static String updateIGN() {
  //   return r'''mutation(
  //     $ign: String!
  //     $user: ID!
  //     ) {
  //       updateUsersPermissionsUser(
  //         data: {
  //           first_name: $first_name
  //           last_name: $last_name
  //         }
  //         id: $user
  //       ) {
  //         data {
  //           id
  //           attributes {
  //             first_name
  //             last_name
  //           }
  //         }
  //       }
  //     }''';
  // }

  static String deregisterEvent() {
    return r'''mutation($registration_id: ID!) {
      deleteEventRegistration (
        input: {
          where: {
            id: $registration_id,
            },
          }){
            eventRegistration {
              updated_at
            }
          }
        }''';
  }

  static String registeredEvents() {
    return r'''query($user_id: ID!, $event_id: ID!) {
     eventRegistrations(filters: {
      event: {
        id: { eq: $event_id},
      }
      user:{
        id:{ eq: $user_id}
      }
    }) {
    data {
      id
      attributes {
        createdAt
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

  static String eventTicket() {
    return r'''query($user_id: ID!, $event_id: ID!) {
  eventRegistrations(filters: { user: { id: { eq: $user_id } } event: { id: { eq: $event_id } }}) {
    data {
      id
      attributes {
        event {
          data {
            id
            attributes {
              name
              event_date
              event_time
              price
              game {
                data {
                  attributes {
                    name
                  }
                }
              }
            }
          }
        }
        user {
          data {
            attributes {
              first_name
              last_name
            }
          }
        }
        reference
        status
        ign
        registered_at
        transaction_id
        createdAt
      }
    }
  }
}''';
  }

  static String userRegisteredEvents() {
    return r'''query($user_id: ID!) {
     eventRegistrations(
      filters: { user: {id: { eq: $user_id }} }
    ) {
      data {
        id
     attributes {
      user {
        data {
          id
          attributes {       
            username
          }
        }
      }
      event {
        data {
          attributes {
            name
        event_date
        event_time
        image {
          data {
            attributes {
              url
            }
          }
        }
          }
        }
      }
      status
      reference
      createdAt
      registered_at
     }
      }}}
  ''';
  }

  static String joinEvent() {
    return r'''mutation($user_id: ID!, $event_id: ID!, $reference: String!) {
      createEventRegistration(
        input: {
          data: {
            event: $event_id
            user: $user_id,
            reference: $reference,
            }
          }){
            eventRegistration {
              id
            }
          }
        }''';
  }
}
