import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openbn/features/circle/domain/entities/queue_invitation_entity.dart';

class CompanyInviteTile extends StatelessWidget {
  final InvitationEntity data;
  String? subHeading;
  final void Function()? onTap;
  CompanyInviteTile(
      {super.key, required this.data, this.onTap, this.subHeading});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: onTap ?? () {},
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: CachedNetworkImageProvider(
          data.invitedJob!.recruiter!.image,
        ),
        child: CachedNetworkImage(
          imageUrl: data.invitedJob!.recruiter!.image,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(),
        ),
      ),
      title: Text(
        data.invitedJob!.recruiter!.name,
        style: textTheme.bodyMedium,
      ),
      subtitle: Text(
        subHeading ?? data.status,
        style: textTheme.labelSmall,
      ),
    );
  }
}
