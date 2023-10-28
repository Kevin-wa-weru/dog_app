part of dog_app_remote_models;

class RemoteBreedNames {
  RemoteBreedNames({
    required this.message,
    required this.status,
  });
  late final Map<String, dynamic> message;
  late final String status;

  RemoteBreedNames.fromJson(Map<String, dynamic> json) {
    message = Map.from(json['message']);
    status = json['status'];
  }
}

class RemoteRandomBreedImage {
  RemoteRandomBreedImage({
    required this.message,
    required this.status,
  });
  late final String message;
  late final String status;

  RemoteRandomBreedImage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }
}

class RemoteBreedImages {
  RemoteBreedImages({
    required this.imageUrls,
    required this.status,
  });
  late final List<String> imageUrls;
  late final String status;

  RemoteBreedImages.fromJson(Map<String, dynamic> json) {
    imageUrls = List.castFrom<dynamic, String>(json['message']);
    status = json['status'];
  }
}
