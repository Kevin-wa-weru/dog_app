part of dog_app_services;

// API calls

class FetchService {
  final String baseUrl = 'https://dog.ceo/api';

  static const headers = {
    "Content-Type": "application/json",
    "Access-Control_Allow_Origin": "*",
  };

  Future<RemoteBreedNames> fetchBreedNames() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/breeds/list/all'),
        headers: headers,
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        RemoteBreedNames breedNames = RemoteBreedNames.fromJson(data);
        return breedNames;
      } else {
        return RemoteBreedNames(
            message: {},
            status: 'failed with status code : $response.statusCode');
      }
    } catch (e) {
      return RemoteBreedNames(message: {}, status: 'failed : ${e.toString()}');
    }
  }

  Future<RemoteSubBreedNames> fetchSubBreedNames(
      {required String breedName}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/breed/$breedName/list'),
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        RemoteSubBreedNames subBreedName = RemoteSubBreedNames.fromJson(data);
        return subBreedName;
      } else {
        return RemoteSubBreedNames(
            message: [],
            status: 'failed with status code : ${response.statusCode}');
      }
    } catch (e) {
      return RemoteSubBreedNames(
          message: [], status: 'failed : ${e.toString()}');
    }
  }

  Future<RemoteRandomBreedImage> fetchRandomBreedImage(
      {required String breedName}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/breed/$breedName/images/random'),
        headers: {"Accept": "application/json"},
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        RemoteRandomBreedImage randomBreedImage =
            RemoteRandomBreedImage.fromJson(data);
        return randomBreedImage;
      } else {
        return RemoteRandomBreedImage(
            message: '',
            status: 'failed with stataus code ${response.statusCode}');
      }
    } catch (e) {
      return RemoteRandomBreedImage(
          message: '', status: 'failed : ${e.toString()}');
    }
  }

  Future<RemoteBreedImages> fetchBreedImageList(
      {required String breedName}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/breed/$breedName/images'),
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        RemoteBreedImages breedImages = RemoteBreedImages.fromJson(data);
        return breedImages;
      } else {
        return RemoteBreedImages(
            imageUrls: [],
            status: 'failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return RemoteBreedImages(
          imageUrls: [], status: 'failed : ${e.toString()}');
    }
  }

  Future<RemoteRandomSubBreedImage> fetchRandomSubBreedImage(
      {required String breedName, required String subBreedName}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/breed/$breedName/$subBreedName/images/random'),
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        RemoteRandomSubBreedImage randomSubBreedImage =
            RemoteRandomSubBreedImage.fromJson(data);
        return randomSubBreedImage;
      } else {
        return RemoteRandomSubBreedImage(
            imageUrl: '',
            status: 'failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return RemoteRandomSubBreedImage(
          imageUrl: '', status: 'failed : ${e.toString()}');
    }
  }

  Future<RemoteSubBreedImages> fetchSubBreedImages(
      {required String breedName, required String subBreedName}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/breed/$breedName/$subBreedName/images'),
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        RemoteSubBreedImages subBreedImages =
            RemoteSubBreedImages.fromJson(data);
        return subBreedImages;
      } else {
        return RemoteSubBreedImages(
            imageUrls: [],
            status: 'failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return RemoteSubBreedImages(
          imageUrls: [], status: 'failed : ${e.toString()}');
    }
  }
}
