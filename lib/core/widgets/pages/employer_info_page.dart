// Core imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Third-party imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:openbn/core/widgets/description_heading.dart';
import 'package:url_launcher/url_launcher.dart';

// Local imports
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/functions/date_services.dart';
import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

// Constants
const double _kHorizontalPadding = 20.0;
const double _kVerticalPadding = 8.0;
const double _kImageSize = 150.0;
const double _kBorderRadius = 8.0;

class EmployerInfoPage extends StatelessWidget {
  final RecruiterModel data;

  const EmployerInfoPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ThemeGap(20),
            _ProfileSection(
              imageUrl: data.image,
              name: data.name,
            ),
            const ThemeGap(10),
            _DateInfoSection(
              createdAt: data.createdAt,
              updatedAt: data.updatedAt,
            ),
            const ThemeGap(20),
            _StatisticsSection(),
            const ThemeGap(10),
            const _Divider(),
            if (data.bio.isNotEmpty) _BioSection(bio: data.bio),
            _SocialMediaSection(
              facebook: data.facebook,
              instagram: data.instagram,
              linkedIn: data.linkedIn,
              x: data.x,
              github: data.github,
            ),
            const _Divider(),
            if (data.address.isNotEmpty) _AddressSection(address: data.address),
            ImageGallery(imageUrls: data.images),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String imageUrl;
  final String name;

  const _ProfileSection({
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        _ProfileImage(imageUrl: imageUrl),
        const ThemeGap(10),
        SizedBox(
          width: 200,
          child: Text(
            name,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final String imageUrl;

  const _ProfileImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        width: _kImageSize,
        height: _kImageSize,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (_, __, ___) => const Icon(
          Icons.apartment,
          size: 35,
        ),
        placeholder: (_, __) => const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _DateInfoSection extends StatelessWidget {
  final String createdAt;
  final String updatedAt;

  const _DateInfoSection({
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateInfo(
          label: 'Joined On',
          value: DateServices.formatDateString(createdAt),
        ),
        _DateInfo(
          label: 'Last Active On',
          value: DateServices.formatDateString(updatedAt),
        ),
      ],
    );
  }
}

class _DateInfo extends StatelessWidget {
  final String label;
  final String value;

  const _DateInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$label : ', style: textTheme.labelMedium),
        Text(value, style: textTheme.labelSmall),
      ],
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 20),
        _StatItem(label: 'Jobs', value: '0'),
        _StatItem(label: 'Invites', value: '0'),
        SizedBox(width: 20),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: textTheme.labelMedium),
        Text(value, style: textTheme.bodyMedium),
      ],
    );
  }
}

class _BioSection extends StatelessWidget {
  final String bio;

  const _BioSection({required this.bio});

  @override
  Widget build(BuildContext context) {
    return _CustomSection(
      content: bio,
      heading: 'Bio',
      enableTopDivider: false,
      enableBottomDivider: true,
    );
  }
}

class _SocialMediaSection extends StatelessWidget {
  final String facebook;
  final String instagram;
  final String linkedIn;
  final String x;
  final String github;

  const _SocialMediaSection({
    required this.facebook,
    required this.instagram,
    required this.linkedIn,
    required this.x,
    required this.github,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SocialButton(type: SocialMedia.FACEBOOK, link: facebook),
        _SocialButton(type: SocialMedia.INSTAGRAM, link: instagram),
        _SocialButton(type: SocialMedia.LINKEDIN, link: linkedIn),
        _SocialButton(type: SocialMedia.X, link: x),
        _SocialButton(type: SocialMedia.GITHUB, link: github),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final SocialMedia type;
  final String link;

  const _SocialButton({required this.type, required this.link});

  String get _assetPath {
    switch (type) {
      case SocialMedia.FACEBOOK:
        return 'assets/icon/facebook.png';
      case SocialMedia.INSTAGRAM:
        return 'assets/icon/instagram.png';
      case SocialMedia.LINKEDIN:
        return 'assets/icon/linkedin.png';
      case SocialMedia.X:
        return 'assets/icon/x.png';
      case SocialMedia.GITHUB:
        return 'assets/icon/github.png';
    }
  }

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(link);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: link.isEmpty ? null : _launchURL,
      icon: Image.asset(
        _assetPath,
        width: 35,
        height: 35,
      ),
    );
  }
}

class _AddressSection extends StatelessWidget {
  final String address;

  const _AddressSection({required this.address});

  @override
  Widget build(BuildContext context) {
    return _CustomSection.withIcon(
      text: address,
      icon: const Icon(Icons.home),
      enableTopDivider: false,
      enableBottomDivider: true,
    );
  }
}

class _CustomSection extends StatelessWidget {
  final String? content;
  final String? heading;
  final Widget? icon;
  final String? text;
  final bool enableTopDivider;
  final bool enableBottomDivider;

  const _CustomSection({
    required this.content,
    required this.heading,
    required this.enableTopDivider,
    required this.enableBottomDivider,
  })  : icon = null,
        text = null;

  const _CustomSection.withIcon({
    required this.text,
    required this.icon,
    required this.enableTopDivider,
    required this.enableBottomDivider,
  })  : content = null,
        heading = null;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (icon != null) {
      return _buildWithIcon(context, textTheme);
    }
    return _buildWithHeading(context, textTheme);
  }

  Widget _buildWithIcon(BuildContext context, TextTheme textTheme) {
    return Column(
      children: [
        if (enableTopDivider) const _Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(text!, style: textTheme.labelMedium),
            )
          ],
        ),
        if (enableBottomDivider) const _Divider(),
      ],
    );
  }

  Widget _buildWithHeading(BuildContext context, TextTheme textTheme) {
    return Column(
      children: [
        if (enableTopDivider) const _Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: DescriptionHeadingWidget(
              heading: heading!, description: content!),
        ),
        if (enableBottomDivider) const _Divider(),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: _kHorizontalPadding),
      child: Divider(
        thickness: 0.4,
      ),
    );
  }
}

class ImageGallery extends StatelessWidget {
  final List<String> imageUrls;

  const ImageGallery({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_kVerticalPadding),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => _GalleryItem(
          imageUrl: imageUrls[index],
          index: index,
        ),
      ),
    );
  }
}

class _GalleryItem extends StatelessWidget {
  final String imageUrl;
  final int index;

  const _GalleryItem({
    required this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEnlargedImage(context),
      child: Hero(
        tag: 'image_$index',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_kBorderRadius),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  void _showEnlargedImage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (context, _, __) => EnlargedImageView(
          borderRadius: 10,
          imageUrl: imageUrl,
          index: index,
        ),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}

class EnlargedImageView extends StatefulWidget {
  final String imageUrl;
  final int index;
  final double borderRadius;

  const EnlargedImageView({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.borderRadius,
  });

  @override
  _EnlargedImageViewState createState() => _EnlargedImageViewState();
}

class _EnlargedImageViewState extends State<EnlargedImageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: widget.borderRadius, end: 0.0)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.reverse().then((_) {
          Navigator.of(context).pop();
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Hero(
                tag: 'image_${widget.index}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
