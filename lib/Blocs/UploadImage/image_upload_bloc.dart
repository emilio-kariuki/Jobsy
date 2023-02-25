import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsy_flutter/Repositories/Upload.dart';

part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  ImageUploadBloc() : super(ImageUploadInitial()) {
    on<ImageUploadEvent>(
      (event, emit) async {
        if (event is UploadButtonPressed) {
          emit(ImageUploadLoading());
          try {
            String url = await Repository()
                .uploadJobImage(image: event.image, path: event.path);
            emit(ImageUploadSuccess(imageUrl: url));
          } catch (e) {
            emit(ImageUploadFailure(error: e.toString()));
            print(e.toString());
          }
        }

        if (event is UpdateProfile) {
          emit(ImageUploadLoading());
          try {
            String url = await Repository()
                .updateProfilePic(image: event.image, path: event.path);
            emit(ImageUploadSuccess(imageUrl: url));
          } catch (e) {
            emit(ImageUploadFailure(error: e.toString()));
            print(e.toString());
          }
        }
      },
    );
  }
}
