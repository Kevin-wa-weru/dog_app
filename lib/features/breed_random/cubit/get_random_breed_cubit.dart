import 'package:bloc/bloc.dart';
import 'package:dog_app/models/_index.dart';
import 'package:dog_app/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_random_breed_state.dart';
part 'get_random_breed_cubit.freezed.dart';

class GetRandomBreedCubit extends Cubit<GetRandomBreedState> {
  GetRandomBreedCubit({
    required FetchService fetchService,
  }) : super(const GetRandomBreedState.initial()) {
    _fetchService = fetchService;
  }

  late FetchService _fetchService;

  Future getRandomBreedImage({required String breedName}) async {
    emit(const GetRandomBreedState.loading());

    RemoteRandomBreedImage randomBreedImage =
        await _fetchService.fetchRandomBreedImage(breedName: breedName);

    if (randomBreedImage.status == 'success') {
      emit(GetRandomBreedState.loaded(
          randomBreedImage.message.toString(), breedName));
    } else {
      emit(GetRandomBreedState.error(randomBreedImage.status));
    }
    //Return for unit testing
    return randomBreedImage.status;
  }
}
