part of dog_app_remote_models;

class RemoteSubBreedNames {
  RemoteSubBreedNames({
    required this.message,
    required this.status,
  });
  late final List<String> message;
  late final String status;

  RemoteSubBreedNames.fromJson(Map<String, dynamic> json) {
    message = List.castFrom<dynamic, String>(json['message']);
    status = json['status'];
  }
}

class RemoteRandomSubBreedImage {
  RemoteRandomSubBreedImage({
    required this.imageUrl,
    required this.status,
  });
  late final String imageUrl;
  late final String status;

  RemoteRandomSubBreedImage.fromJson(Map<String, dynamic> json) {
    imageUrl = json['message'];
    status = json['status'];
  }
}

class RemoteSubBreedImages {
  RemoteSubBreedImages({
    required this.imageUrls,
    required this.status,
  });
  late final List<String> imageUrls;
  late final String status;

  RemoteSubBreedImages.fromJson(Map<String, dynamic> json) {
    imageUrls = List.castFrom<dynamic, String>(json['message']);
    status = json['status'];
  }
}
