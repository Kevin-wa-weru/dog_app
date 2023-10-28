import 'package:bloc/bloc.dart';
import 'package:dog_app/models/_index.dart';
import 'package:dog_app/services/_index.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_breed_names_state.dart';
part 'get_breed_names_cubit.freezed.dart';

class GetBreedNamesCubit extends Cubit<GetBreedNamesState> {
  GetBreedNamesCubit({
    required FetchService fetchService,
    required NameService nameService,
  }) : super(const GetBreedNamesState.initial()) {
    _fetchService = fetchService;
    _nameService = nameService;
  }

  late FetchService _fetchService;
  late NameService _nameService;

  Future getBreedNames({
    required bool isFirstTimeGetting,
    CurrentTabScreen? currentTab,
    String? selectedbreedName,
  }) async {
    emit(const GetBreedNamesState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    late String fetchStatus = '';

//If its first time fetching get remote names and update local storage

    if (isFirstTimeGetting) {
      RemoteBreedNames remoteBreedNames = await _fetchService.fetchBreedNames();
      fetchStatus = remoteBreedNames.status;
      if (remoteBreedNames.status == 'success') {
        late List<String> breedNames = [];

        remoteBreedNames.message.forEach((key, value) {
          breedNames.add(key);
        });
        _nameService.setInitialBreedValues(breedName: breedNames.first);
        _nameService.updateBreedList(
          breedNamesList: breedNames,
        );
        emit(GetBreedNamesState.loaded(
          breedNames,
          breedNames.first,
          breedNames.first,
          breedNames.first,
          breedNames.first,
        ));
      }
    }

    //If not first time get list in local storage and update each dropdown recently selected values

    if (isFirstTimeGetting == false) {
      fetchStatus = 'failed';
      String? localBreddTabOne = prefs.getString(
        'selectedBreedTabOne',
      );
      String? localBreddTabTwo = prefs.getString(
        'selectedBreedTabTwo',
      );
      String? localBreddTabThree = prefs.getString(
        'selectedBreedTabThree',
      );
      String? localBreddTabFour = prefs.getString(
        'selectedBreedTabFour',
      );
      List<String>? localBreedList = prefs.getStringList(
        'breedNamesList',
      );

      switch (currentTab) {
        case CurrentTabScreen.tabOne:
          await prefs.setString('selectedBreedTabOne', selectedbreedName!);
          emit(GetBreedNamesState.loaded(
            localBreedList!,
            selectedbreedName,
            localBreddTabTwo!,
            localBreddTabThree!,
            localBreddTabFour!,
          ));
          break;
        case CurrentTabScreen.tabTwo:
          await prefs.setString('selectedBreedTabTwo', selectedbreedName!);
          emit(GetBreedNamesState.loaded(
            localBreedList!,
            localBreddTabOne!,
            selectedbreedName,
            localBreddTabThree!,
            localBreddTabFour!,
          ));
          break;
        case CurrentTabScreen.tabThree:
          await prefs.setString('selectedBreedTabThree', selectedbreedName!);
          emit(GetBreedNamesState.loaded(
            localBreedList!,
            localBreddTabOne!,
            localBreddTabTwo!,
            selectedbreedName,
            localBreddTabFour!,
          ));
          break;
        case CurrentTabScreen.tabFour:
          await prefs.setString('selectedBreedTabFour', selectedbreedName!);
          emit(GetBreedNamesState.loaded(
            localBreedList!,
            localBreddTabOne!,
            localBreddTabTwo!,
            localBreddTabThree!,
            selectedbreedName,
          ));
          break;
        default:
      }
    }

// Return for unit testing
    return fetchStatus;
  }
}
