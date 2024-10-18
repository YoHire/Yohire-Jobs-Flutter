import 'package:flutter/material.dart';
import 'package:openbn/core/services/file_convert_service.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final JobEntity job;

  const ShareButton({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () async {
          // Convert the asset to XFile
          XFile xFile = await FileConverterService.assetToXFile(
              'assets/images/refferal-banner.png');

          final RenderBox box = context.findRenderObject() as RenderBox;

          // Share the file and text with the correct position and size of the button
          final result = await Share.shareXFiles(
            [xFile],
            text:
                'Hey, take a look at this job I found: https://app.yohire.in/job/${job.id}',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
          );

          // Handle success if needed
          if (result.status == ShareResultStatus.success) {
            // Do something on success
          }
        },
        icon: Image.asset(
          'assets/icon/sent.png',
          width: 25,
          height: 25,
        ),
      );
    });
  }
}
