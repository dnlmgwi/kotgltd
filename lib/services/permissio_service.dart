// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PermissionService {
//   static final PermissionService _permissionService =
//       PermissionService._internal();

//   factory PermissionService() {
//     return _permissionService;
//   }

//   Future<bool> requestContactsPermission({Function onPermissionDenied}) async {
//     var granted = await _requestPermission(Permission.v);
//     if (!granted) {
//       onPermissionDenied();
//     }
//     return granted;
//   }

//    Future<bool> _requestPermission(Permission permission) async {
//     var result = await _permissionService.requestPermissions([permission]);
//     if (result[permission] == PermissionStatus.granted) {
//       return true;
//     }
//     return false;
//   }
// }
