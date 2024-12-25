
import 'package:utils/utils.dart';

const _isLoggedKey = 'isLoggedLey';

class DataLocal {
  static bool isLogged() =>  UserPreferences().getBool(_isLoggedKey);
  static void setLogged(bool value) async =>  await UserPreferences().setBool(_isLoggedKey, value);
}