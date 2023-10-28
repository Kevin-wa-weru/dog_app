part of 'get_sub_breed_names_cubit.dart';

@freezed
class GetSubBreedNamesState with _$GetSubBreedNamesState {
  const factory GetSubBreedNamesState.initial() = _Initial;
  const factory GetSubBreedNamesState.loading() = _Loading;
  const factory GetSubBreedNamesState.loaded(
    List<String> subBreedNamesTabThree,
    List<String> subBreedNamesTabFour,
  ) = _Loaded;
  const factory GetSubBreedNamesState.error(String errorMessage) = _Error;
}
