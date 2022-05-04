class EventsQueries {
  static String getAllEvents() {
    return r'''query {
  events(
    sort: "event_date:desc", publicationState:LIVE,
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
      }
    }
  }
}''';
  }

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
