import 'package:envify/envify.dart';

part 'enviroment_creds.g.dart';

@Envify()
abstract class Env {
  static const baseUrl = _Env.baseUrl;
  static const domainUrl = _Env.domainUrl;
}
