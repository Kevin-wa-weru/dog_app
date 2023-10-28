part of 'get_breed_images_cubit.dart';

@freezed
class GetBreedImagesState with _$GetBreedImagesState {
  const factory GetBreedImagesState.initial() = _Initial;
  const factory GetBreedImagesState.loading() = _Loading;
  const factory GetBreedImagesState.loaded(List<String> imageUrls) = _Loaded;
  const factory GetBreedImagesState.error(String message) = _Error;
}
