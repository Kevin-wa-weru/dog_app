import 'package:bloc/bloc.dart';
import 'package:dog_app/models/_index.dart';
import 'package:dog_app/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_breed_images_state.dart';
part 'get_breed_images_cubit.freezed.dart';

class GetBreedImagesCubit extends Cubit<GetBreedImagesState> {
  GetBreedImagesCubit({
    required FetchService fetchService,
  }) : super(const GetBreedImagesState.initial()) {
    _fetchService = fetchService;
  }

  late FetchService _fetchService;

  Future getBreedImages({
    required String breedName,
  }) async {
    emit(const GetBreedImagesState.loading());

    RemoteBreedImages breedImages =
        await _fetchService.fetchBreedImageList(breedName: breedName);

    if (breedImages.status == 'success') {
      emit(GetBreedImagesState.loaded(breedImages.imageUrls));
    } else {
      emit(GetBreedImagesState.error(breedImages.status));
    }

    //Return for unit testing
    return breedImages.status;
  }
}
