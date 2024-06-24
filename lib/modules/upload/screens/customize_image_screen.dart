import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/modules/upload/cubit/cubit/upload_media_cubit.dart';
import 'package:oshinstar/modules/upload/screens/widgets/bottom_upload.dart';
import 'package:oshinstar/modules/upload/screens/widgets/current_image.dart';
import 'package:oshinstar/modules/upload/screens/widgets/original_work.dart';
import 'package:oshinstar/modules/upload/screens/widgets/uploaded_images.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class CustomizeImageScreen extends StatelessWidget {
  const CustomizeImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UploadMediaCubit>().state;
    final images = state.images;
    final selected = state.selected;
    final selectedImage = selected == null ? null : images[selected];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text('Customize Image'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Add Title',
                counterText: '0/100',
              ),
            ),
          ),
          OriginalWork(
            onChanged: (value) {
              context.read<UploadMediaCubit>().changeOriginalWork(value);
            },
          ),
          const SizedBox(height: 10),
          CurrentImage(
            imageBytes: selectedImage,
            onEditImage: () {
              context
                  .read<UploadMediaCubit>()
                  .cropImage(context);
            },
            onRemoveImage: () {
              context.read<UploadMediaCubit>().removeImage(selected!);
            },
          ),
          const SizedBox(height: 10),
          UploadedImages(
            img: images,
            selectedIndex: selected ?? -1,
            onTap: (value) {
              context.read<UploadMediaCubit>().selectImage(value);
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: OshinPalette.blue,
              foregroundColor: OshinPalette.white,
            ),
            child: const Text('Add details to your image'),
          ),
          const Spacer(),
          BottomUpload(
            onUploadPressed: () {
              context.read<UploadMediaCubit>().pickImage();
            },
          ),
        ],
      ),
    );
  }
}
