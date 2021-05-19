import 'package:localstorage/localstorage.dart';

class Storage {
  final LocalStorage storage = LocalStorage("storage");
  Future<bool> needUpdate() async {
    await storage.ready;

    if (storage.getItem('date') != null &&
        DateTime.now()
                .difference(DateTime.parse(storage.getItem('date')!))
                .inSeconds <=
            600) {
      return false;
    } else {
      storage.setItem('date', DateTime.now().toString());
      return true;
    }
  }

  Future<void> setRecipes(String recipes) async {
    await storage.ready;
    storage.setItem('recipes', recipes);
  }

  Future<String?> getRecipes() async {
    await storage.ready;
    return storage.getItem('recipes');
  }

  // Future<void> saveFavorites(String fav) async {
  //   await storage.ready;
  //   storage.setItem("favorites", []..add(fav));
  // }
  // Future<List<String>> getFavorites()async{
  //   await storage.ready;
  //   stora.getItem("favoristes")
  // }
}
