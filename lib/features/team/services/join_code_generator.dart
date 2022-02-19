import 'package:uuid/uuid.dart';

class InviteCodeGenerator {
  var uuid = Uuid().v4().split('-')[1];

  Future<String> createInviteCode(String teamName) async {
    var inviteCode = '${teamName.replaceAll(' ', '')}-$uuid';
    return inviteCode;
  }
}
