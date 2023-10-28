part of dog_app_services;

//Service class to persist selected names locally

class NameService {
  Future setInitialBreedValues({
    required String breedName,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedBreedTabOne', breedName);
    prefs.setString('selectedBreedTabTwo', breedName);
    prefs.setString('selectedBreedTabThree', breedName);
    prefs.setString('selectedBreedTabFour', breedName);
  }

  Future updateBreedList({
    required List<String> breedNamesList,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('breedNamesList', breedNamesList);
  }

  Future updateSubreedLists({
    required List<String> subBreedsTabThree,
    required List<String> subBreedsTabFour,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('subBreedsTabThree', subBreedsTabThree);
    prefs.setStringList('subBreedsTabFour', subBreedsTabFour);
  }

  Future updateSelectedBreed({
    required String breedName,
    required CurrentTabScreen currentTab,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentTab == CurrentTabScreen.tabThree) {
      prefs.setString('selectedBreedTabThree', breedName);
    }
    if (currentTab == CurrentTabScreen.tabFour) {
      prefs.setString('selectedBreedTabFour', breedName);
    }
  }
}
