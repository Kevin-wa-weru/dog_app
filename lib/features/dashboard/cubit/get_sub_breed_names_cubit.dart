import 'package:bloc/bloc.dart';
import 'package:dog_app/models/_index.dart';
import 'package:dog_app/services/_index.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_sub_breed_names_state.dart';
part 'get_sub_breed_names_cubit.freezed.dart';

class GetSubBreedNamesCubit extends Cubit<GetSubBreedNamesState> {
  GetSubBreedNamesCubit({
    required FetchService fetchService,
    required NameService nameService,
  }) : super(const GetSubBreedNamesState.initial()) {
    _fetchService = fetchService;
    _nameService = nameService;
  }

  late FetchService _fetchService;
  late NameService _nameService;

  Future getSubBreedNames({
    required String selectedBreed,
    required bool isFirsTimeGetting,
    CurrentTabScreen? tabToUpdate,
  }) async {
    emit(const GetSubBreedNamesState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? localSubBreedTabThree =
        prefs.getStringList('subBreedsTabThree');
    List<String>? localSubBreedTabFour =
        prefs.getStringList('subBreedsTabFour');

    RemoteSubBreedNames remoteSubBreedNames =
        await _fetchService.fetchSubBreedNames(breedName: selectedBreed);

    if (remoteSubBreedNames.status == 'success') {
      if (isFirsTimeGetting) {
        _nameService.updateSubreedLists(
            subBreedsTabThree: remoteSubBreedNames.message,
            subBreedsTabFour: remoteSubBreedNames.message);
      }

      switch (tabToUpdate) {
        case CurrentTabScreen.tabThree:
          _nameService.updateSelectedBreed(
              breedName: selectedBreed, currentTab: tabToUpdate!);
          emit(GetSubBreedNamesState.loaded(
              remoteSubBreedNames.message, localSubBreedTabFour!));

          prefs.setStringList('subBreedsTabThree', remoteSubBreedNames.message);
          break;
        case CurrentTabScreen.tabFour:
          _nameService.updateSelectedBreed(
              breedName: selectedBreed, currentTab: tabToUpdate!);
          emit(GetSubBreedNamesState.loaded(
              localSubBreedTabThree!, remoteSubBreedNames.message));
          prefs.setStringList('subBreedsTabFour', remoteSubBreedNames.message);
          break;
        default:
          emit(GetSubBreedNamesState.loaded(
              remoteSubBreedNames.message, remoteSubBreedNames.message));
      }
    } else {
      emit(GetSubBreedNamesState.error(remoteSubBreedNames.status));
    }

    //Return for unit testing
    return remoteSubBreedNames.status;
  }
}
