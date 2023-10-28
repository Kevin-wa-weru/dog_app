part of 'get_random_sub_breed_cubit.dart';

@freezed
class GetRandomSubBreedState with _$GetRandomSubBreedState {
  const factory GetRandomSubBreedState.initial() = _Initial;
  const factory GetRandomSubBreedState.loading() = _Loading;
  const factory GetRandomSubBreedState.loaded(String imageUrl) = _Loaded;
  const factory GetRandomSubBreedState.error(String errorMessage) = _Error;
}
