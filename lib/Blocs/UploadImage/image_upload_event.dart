part of 'image_upload_bloc.dart';

abstract class ImageUploadEvent extends Equatable {
  const ImageUploadEvent();

  @override
  List<Object> get props => [];
}

class UploadButtonPressed extends ImageUploadEvent {
  var image;
  String path;

  UploadButtonPressed({required this.image, required this.path});
}

class UploadTryAgain extends ImageUploadEvent {
  final File image;

  const UploadTryAgain({required this.image});
}

class UpdateProfile extends ImageUploadEvent {
  var image;
  String path;

  UpdateProfile({required this.image, required this.path});
}