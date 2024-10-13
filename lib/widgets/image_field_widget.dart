import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/common/extension/text_style_extension.dart';
import 'package:product_management/common/utils/pick_image.dart';
import 'package:product_management/common/utils/show_snackbar.dart';
import 'package:product_management/models/form_field.dart';

class ImageFieldWidget extends StatelessWidget {
  const ImageFieldWidget({
    super.key,
    required this.onImgFileChanged,
    required this.imgfile,
    required this.properties,
  });

  final Function(File imgfile) onImgFileChanged;
  final File? imgfile;
  final ImageFieldProperties properties;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: properties.required ? '* ' : '',
              children: [
                TextSpan(
                  text: properties.label,
                  style: context.textTheme.labelLarge?.w600,
                ),
              ],
              style: context.textTheme.labelLarge?.w600.error),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            var pickFile = await pickImage();
            if (pickFile != null) {
              int fileSizeInBytes = await pickFile.length();
              double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
              if (fileSizeInMB > 5) {
                if (context.mounted) {
                  showSnackBar(
                      context, 'Kích thước file lớn hơn 5MB: $fileSizeInMB MB');
                }
              } else {
                onImgFileChanged(pickFile);
              }
            }
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.cloud_upload, size: 20),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    imgfile != null
                        ? basename(imgfile!.path).split('image_picker_').last
                        : 'Chọn tệp tin (tối đa 5MB)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.w600,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
