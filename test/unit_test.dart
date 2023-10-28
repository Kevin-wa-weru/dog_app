import 'package:dog_app/features/breed_image_list/cubit/get_breed_images_cubit.dart';
import 'package:dog_app/features/breed_random/cubit/get_random_breed_cubit.dart';
import 'package:dog_app/features/dashboard/cubit/get_breed_names_cubit.dart';
import 'package:dog_app/features/dashboard/cubit/get_sub_breed_names_cubit.dart';
import 'package:dog_app/features/sub_breed_image_list/cubit/get_sub_breed_images_cubit.dart';
import 'package:dog_app/features/sub_breed_random/cubit/get_random_sub_breed_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dog_app/services/_index.dart';

//Unit test for all the fetch functions in cubits
//
//Each test requires an active internet connection to run

void main() {
  FetchService fetchService = FetchService();
  NameService nameService = NameService();
  group('getBreedNames', () {
    test('Returns success message if successful', () async {
      String status = await GetBreedNamesCubit(
              fetchService: fetchService, nameService: nameService)
          .getBreedNames(isFirstTimeGetting: true);

      expect(status, 'success');
    });
    test('Returns failed message is not successful', () async {
      String status = await GetBreedNamesCubit(
              fetchService: fetchService, nameService: nameService)
          .getBreedNames(isFirstTimeGetting: false);

      expect(status.contains('failed'), true);
    });
  });

  group('getRandomBreedImage', () {
    test('Returns success message if successful', () async {
      String status = await GetRandomBreedCubit(
        fetchService: fetchService,
      ).getRandomBreedImage(breedName: 'hound');

      expect(status, 'success');
    });
    test('Returns failed message is not successful', () async {
      String status = await GetRandomBreedCubit(
        fetchService: fetchService,
      ).getRandomBreedImage(breedName: 'dummyname');

      expect(status.contains('failed'), true);
    });
  });

  group('getBreedImages', () {
    test('Returns success message if successful', () async {
      String status = await GetBreedImagesCubit(
        fetchService: fetchService,
      ).getBreedImages(breedName: 'hound');
      expect(status, 'success');
    });
    test('Returns failed message is not successful', () async {
      String status = await GetBreedImagesCubit(
        fetchService: fetchService,
      ).getBreedImages(breedName: 'dummyName');

      expect(status.contains('failed'), true);
    });
  });

  group('getSubBreedNames', () {
    test('Returns success message if successful', () async {
      String status = await GetSubBreedNamesCubit(
        fetchService: fetchService,
        nameService: nameService,
      ).getSubBreedNames(
        selectedBreed: 'hound',
        isFirsTimeGetting: false,
      );
      expect(status, 'success');
    });
    test('Returns failed message is not successful', () async {
      String status = await GetSubBreedNamesCubit(
        fetchService: fetchService,
        nameService: nameService,
      ).getSubBreedNames(
        selectedBreed: 'dummyName',
        isFirsTimeGetting: false,
      );

      expect(status.contains('failed'), true);
    });
  });

  group('getRandomSubBreedImage', () {
    test('Returns success message if successful', () async {
      String status = await GetRandomSubBreedCubit(
        fetchService: fetchService,
      ).getRandomSubBreedImage(
        breedName: 'hound',
        subBreedName: 'afghan',
      );
      expect(status, 'success');
    });
    test('Returns failed message is not successful', () async {
      String status = await GetRandomSubBreedCubit(
        fetchService: fetchService,
      ).getRandomSubBreedImage(
        breedName: 'dummyName',
        subBreedName: 'afghan',
      );

      expect(status.contains('failed'), true);
    });
  });

  group('getSubBreedImages', () {
    test('Returns success message if successful', () async {
      String status = await GetSubBreedImagesCubit(
        fetchService: fetchService,
      ).getSubBreedImages(
        breedName: 'hound',
        subBreedName: 'afghan',
      );
      expect(status, 'success');
    });
    test('Returns failed message is not successful', () async {
      String status = await GetSubBreedImagesCubit(
        fetchService: fetchService,
      ).getSubBreedImages(
        breedName: 'dummyName',
        subBreedName: 'dummyName',
      );

      expect(status.contains('failed'), true);
    });
  });
}
