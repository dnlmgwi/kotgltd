import 'package:kotgltd/features/auth/model/user.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:uuid/uuid.dart';

class ReferenceGenerator {
  final user = Hive.box<User>('user');

  Future<String> createReference(String eventName) async {
    var uuid = Uuid().v4().split('-')[1];
    User? _user = user.values.first;
    var reference = '${_user.username}-${eventName.replaceAll(' ', '')}-$uuid';
    return reference;
  }
}
