part of 'get_random_breed_cubit.dart';

@freezed
class GetRandomBreedState with _$GetRandomBreedState {
  const factory GetRandomBreedState.initial() = _Initial;
  const factory GetRandomBreedState.loading() = _Loading;
  const factory GetRandomBreedState.loaded(
      String imageUrl, String selectedBreedName) = _Loaded;
  const factory GetRandomBreedState.error(String errorMessage) = _Error;
}
