class TeamQueries {
  ///{
  ///"team_name": "gs23cyd",
  ///"captain": "1"
  ///}
  static String createTeam() {
    return r'''mutation($team_name: String!, $captain: ID!) {
      createTeam(
          data: {
            team_name: $team_name,
            captain: $captain,
            }
      ){
    data{
      id
      attributes{
        team_name
      }
    }
  }
        }''';
  }

  ///Team Have Joined
  static String getJoinedTeam() {
    return r'''query($member_id: ID!) {
      teamJoinRequests(where: {
        member: $member_id
        }){
          id
          team {
            id
            team_name
            created_at
            invite_code
            team_members {
              member {
                username
                profile {
              avatar {
                image {
                  url
                }
              }
            }
          }
        }
      
    }
  }
  }''';
  }

  static String deleteTeam() {
    return r'''mutation($team_id: ID!,) {
      updateTeam (
        input: {
          where: {
            id: $team_id,
            },
            data: {
              deleted: true
            }
          }){
            team {
              team_name
            }
          }
        }''';
  }

  /// Limit is 5 Gamers only
  /// Fetched in Ascending order of Request Date/Time
  static String fetchTeamJoinRequests() {
    return r'''query($invite_code: String!) {
  invites(filters: { invite_code: { eq: $invite_code } }) {
    data {
      id
      attributes {
        user {
          data {
            attributes {
              
              email
              
              avatar {
                
                data {
                  
                  attributes {
                    
                    url
                  }
                }
              }
            }
          }
        }
        claimed
      }
    }
    meta {
      pagination {
        total
      }
    }
  }
}
''';
  }

  static String fetchTeamJoinRequestsCount() {
    return r'''query($invite_code: String!) {
  invites(filters: { invite_code: { eq: $invite_code } }) {
    
    meta {
      pagination {
        total
      }
    }
  }
}''';
  }

  static String deleteTeamJoinRequests() {
    return r'''mutation($request_id: ID!){
      deleteTeamJoinRequest(input: {
        where: {
          id: $request_id
          }
        }){
          teamJoinRequest {
            created_at
          }
        }
      }''';
  }
}
