import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserAvatarWidget extends StatelessWidget {
  final bool selected;
  final String? src;
  final double size;
  final double? sizeIconPlaceHolder;
  final double elevation;
  final bool showBorder;
  final bool dottedBorder;
  final double widthBorder;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final bool? hasAvatar;
  final Map<String, String>? httpHeaders;
  final String genderPlaceHolder;
  final Widget? avatarPlaceholder;

  const UserAvatarWidget({
    Key? key,
    this.src,
    this.hasAvatar,
    this.size = 45,
    this.sizeIconPlaceHolder,
    this.elevation = 0,
    this.showBorder = false,
    this.dottedBorder = false,
    this.widthBorder = 3,
    this.selected = false,
    this.borderColor,
    this.selectedBorderColor,
    this.httpHeaders,
    this.genderPlaceHolder = "male",
    this.avatarPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: CachedNetworkImage(
        imageUrl: src ?? '',
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        errorWidget: (context, url, error) => avatarPlaceholder ?? _placeholderIcon(),
      ),
    );

    if (showBorder) {
      avatar = _buildBorderedAvatar(context, avatar);
    } else {
      avatar = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: avatar,
      );
    }

    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(100.0),
      child: avatar,
    );
  }

  Widget _placeholderIcon() {
    if (hasAvatar == true && src?.isNotEmpty == true) {
      return const Icon(Icons.visibility_off);
    }
    return Icon(
      genderPlaceHolder == "female" ? MdiIcons.faceWoman : Icons.face,
      size: sizeIconPlaceHolder ?? (size / 2),
      color: Colors.white,
    );
  }

  Widget _buildBorderedAvatar(BuildContext context, Widget avatar) {
    return dottedBorder
        ? DottedBorder(
            borderType: BorderType.Circle,
            color: borderColor ?? Colors.orangeAccent,
            dashPattern: [5, 7],
            strokeWidth: 2,
            padding: const EdgeInsets.all(5),
            strokeCap: StrokeCap.round,
            child: _borderedContainer(avatar),
          )
        : Container(
            key: const ValueKey('profile_avatar'),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(
                width: widthBorder,
                color: selected
                    ? selectedBorderColor ?? Theme.of(context).primaryColor
                    : borderColor ?? Colors.grey.shade900,
              ),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: avatar,
          );
  }

  Widget _borderedContainer(Widget avatar) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: avatar,
    );
  }
}
