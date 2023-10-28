import 'package:bloc/bloc.dart';
import 'package:dog_app/models/_index.dart';
import 'package:dog_app/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_random_sub_breed_state.dart';
part 'get_random_sub_breed_cubit.freezed.dart';

class GetRandomSubBreedCubit extends Cubit<GetRandomSubBreedState> {
  GetRandomSubBreedCubit({
    required FetchService fetchService,
  }) : super(const GetRandomSubBreedState.initial()) {
    _fetchService = fetchService;
  }

  late FetchService _fetchService;

  Future getRandomSubBreedImage(
      {required String subBreedName, String? breedName}) async {
    emit(const GetRandomSubBreedState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String breedNameToUse = '';

    if (breedName == null) {
      String? selectedBreed = prefs.getString('selectedBreedTabThree');

      breedNameToUse = selectedBreed!;
    } else {
      breedNameToUse = breedName;
    }

    RemoteRandomSubBreedImage randomSubBreedImage =
        await _fetchService.fetchRandomSubBreedImage(
            breedName: breedNameToUse, subBreedName: subBreedName);

    if (randomSubBreedImage.status == 'success') {
      emit(GetRandomSubBreedState.loaded(randomSubBreedImage.imageUrl));
    } else {
      emit(GetRandomSubBreedState.error(randomSubBreedImage.status));
    }
    //For unit testing
    return randomSubBreedImage.status;
  }
}
