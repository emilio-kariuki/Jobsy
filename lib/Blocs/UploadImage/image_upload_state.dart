part of 'image_upload_bloc.dart';

abstract class ImageUploadState extends Equatable {
  const ImageUploadState();
  
  @override
  List<Object> get props => [];
}

class ImageUploadInitial extends ImageUploadState {}

class ImageUploadLoading extends ImageUploadState {}

class ImageUploadSuccess extends ImageUploadState {
  final String imageUrl;

  const ImageUploadSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class ImageUploadFailure extends ImageUploadState {
  final String error;

  const ImageUploadFailure({required this.error});

  @override
  List<Object> get props => [error];
}


