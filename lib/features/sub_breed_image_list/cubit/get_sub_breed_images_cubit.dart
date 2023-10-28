import 'package:bloc/bloc.dart';
import 'package:dog_app/models/_index.dart';
import 'package:dog_app/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'get_sub_breed_images_state.dart';
part 'get_sub_breed_images_cubit.freezed.dart';

class GetSubBreedImagesCubit extends Cubit<GetSubBreedImagesState> {
  GetSubBreedImagesCubit({
    required FetchService fetchService,
  }) : super(const GetSubBreedImagesState.initial()) {
    _fetchService = fetchService;
  }

  late FetchService _fetchService;

  Future getSubBreedImages(
      {required String subBreedName, String? breedName}) async {
    emit(const GetSubBreedImagesState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String breedNameToUse = '';

    if (breedName == null) {
      String? selectedBreed = prefs.getString('selectedBreedTabFour');

      breedNameToUse = selectedBreed!;
    } else {
      breedNameToUse = breedName;
    }

    RemoteSubBreedImages subBreedImages =
        await _fetchService.fetchSubBreedImages(
            breedName: breedNameToUse, subBreedName: subBreedName);

    if (subBreedImages.status == 'success') {
      emit(GetSubBreedImagesState.loaded(subBreedImages.imageUrls));
    } else {
      emit(GetSubBreedImagesState.error(subBreedImages.status));
    }

    return subBreedImages.status;
  }
}
