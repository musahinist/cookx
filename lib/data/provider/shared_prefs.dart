import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> needUpdate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('date') &&
        DateTime.parse(prefs.getString('date')!).difference(DateTime.now()) <=
            const Duration(minutes: 30)) {
      return false;
    } else {
      await prefs.setString('date', DateTime.now().toString());
      return true;
    }
  }

  Future<void> setRecipes(String recipes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('recipes', recipes);
  }

  Future<String?> getRecipes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('recipes');
  }
}
