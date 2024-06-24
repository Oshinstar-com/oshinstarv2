part of 'upload_media_cubit.dart';

class UploadMediaState extends Equatable {
  const UploadMediaState({
    this.images = const [],
    this.selected,
    this.originalWork = false,
  });

  final List<Uint8List> images;
  final int? selected;
  final bool originalWork;

  @override
  List<Object?> get props => [images, selected, originalWork];
}
