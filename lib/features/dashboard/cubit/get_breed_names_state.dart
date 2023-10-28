part of 'get_breed_names_cubit.dart';

@freezed
class GetBreedNamesState with _$GetBreedNamesState {
  const factory GetBreedNamesState.initial() = _Initial;
  const factory GetBreedNamesState.loading() = _Loading;
  const factory GetBreedNamesState.loaded(
    List<String> breedNames,
    String selectedBreedTabOne,
    String selectedBreedTabTwo,
    String selectedBreedTabThree,
    String selectedBreedTabFour,
  ) = _Loaded;
  const factory GetBreedNamesState.error(String errorMessage) = _Error;
}
