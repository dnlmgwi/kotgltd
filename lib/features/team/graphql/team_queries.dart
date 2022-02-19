class TeamQueries {
  ///{
  ///"team_name": "gs23cyd",
  ///"invite_code": "643q64",
  ///"captain": "1"
  ///}
  static String createTeam() {
    return r'''mutation($team_name: String!, $invite_code: String!, $captain: ID!) {
      createTeam(
        input: {
          data: {
            team_name: $team_name,
            invite_code: $invite_code,
            captain: $captain,
            }
          }){
            team {
              id
              team_name
              invite_code
            }
          }
        }''';
  }

  /// {
  /// "captain_id": "1"
  /// }
  static String getMyCreatedTeam() {
    return r'''query($captain_id: ID!) {
      teams(where:{
        captain:{
          id: $captain_id,
        },
        deleted: false
      }){
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

  ///{
  ///invite_code: $invite_code,
  ///member: $member_id
  ///}
  static String createJoinRequest() {
    return r'''mutation($member_id: ID , $invite_code: String!){
      createTeamJoinRequest (    
        input: {
          data: {  
            invite_code: $invite_code,
            member: $member_id
          }
        }){
          teamJoinRequest {
            id
          }
        }
      }''';
  }

  static String claimJoinRequest() {
    return r'''mutation($request_id: ID!, $team_id: ID){
      updateTeamJoinRequest(
        input: {
          where: {
            id: $request_id,
            },
            data: {
              team: $team_id
              claimed: true
            }}){
              teamJoinRequest {
                claimed
                team {
                  id
                }
              }
            }
          }''';
  }

  /// Limit is 5 Gamers only
  /// Fetched in Ascending order of Request Date/Time
  static String fetchTeamJoinRequests() {
    return r'''query($invite_code: String!) {
      teamJoinRequests(where: {invite_code_eq: $invite_code}, limit: 5, sort: "created_at:asc"){
        id
        member {
          id
          username
          profile {
              avatar {
                image {
                  url
                }
              }
            }
        }
        claimed
      }
    }''';
  }

  static String fetchTeamJoinRequestsCount() {
    return r'''query($invite_code: String!) {
      teamJoinRequestsConnection( where: {invite_code_eq: $invite_code, claimed: false}){
        aggregate {
          count
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
