part of 'get_sub_breed_images_cubit.dart';

@freezed
class GetSubBreedImagesState with _$GetSubBreedImagesState {
  const factory GetSubBreedImagesState.initial() = _Initial;
  const factory GetSubBreedImagesState.loading() = _Loading;
  const factory GetSubBreedImagesState.loaded(List imageUrls) = _Loaded;
  const factory GetSubBreedImagesState.error(String errorMessage) = _Error;
}
