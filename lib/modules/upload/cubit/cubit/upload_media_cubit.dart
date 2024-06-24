import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:path_provider/path_provider.dart';

part 'upload_media_state.dart';

class UploadMediaCubit extends Cubit<UploadMediaState> {
  UploadMediaCubit() : super(const UploadMediaState());

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final bytes = await image.readAsBytes();
    final images = state.images;
    final selected = state.images.length;
    emit(UploadMediaState(
      images: List.of(images)..add(bytes),
      selected: selected,
    ));
  }

  void changeOriginalWork(bool value) {
    emit(UploadMediaState(
      images: state.images,
      selected: state.selected,
      originalWork: value,
    ));
  }

  void removeImage(int index) {
    final images = List<Uint8List>.from(state.images);
    images.removeAt(index);
    final selected = switch (state.selected) {
      null => 0,
      0 => null,
      _ => state.selected! - 1,
    };
    emit(UploadMediaState(
      images: images,
      selected: selected,
      originalWork: state.originalWork,
    ));
  }

  void selectImage(int index) {
    emit(UploadMediaState(
      images: state.images,
      selected: index,
      originalWork: state.originalWork,
    ));
  }

  void cropImage(BuildContext context) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/image.jpg';
    final file = File(tempPath);
    if (file.existsSync()) await file.delete();
    await file.writeAsBytes(state.images[state.selected!]);
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: tempPath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: OshinPalette.blue,
          toolbarWidgetColor: OshinPalette.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      final bytes = await croppedFile.readAsBytes();
      final images = state.images;
      final selected = state.selected;
      final newImages = List<Uint8List>.from(images);
      newImages[selected!] = bytes;
      emit(UploadMediaState(
        images: newImages,
        selected: selected,
        originalWork: state.originalWork,
      ));
    }
  }
}
