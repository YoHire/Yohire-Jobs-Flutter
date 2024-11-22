// import 'package:flutter/material.dart';
// import 'package:openbn/core/widgets/main_heading_sub_heading.dart';

// class ProfileContainerSection extends StatelessWidget {
//   final bool isCompleted;
//   final String heading;
//   final Icon icon;
//   final String subHeading;
//   final void Function()? onTap;
//   const ProfileContainerSection(
//       {super.key,
//       required this.isCompleted,
//       required this.heading,
//       required this.icon,
//       required this.subHeading,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final colorTheme = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Stack(
//         children: [
//           InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(15.0),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: colorTheme.surface,
//                   borderRadius: BorderRadius.circular(15.0),
//                   border: Border.all(width: 0.1)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Row(
//                   children: [
//                    icon,
//                     const SizedBox(width: 15),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       child: leftHeadingWithSub(
//                           context: context,
//                           heading: heading,
//                           subHeading: subHeading),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           isCompleted
//               ? Positioned(
//                   right: 4.5,
//                   bottom: 4.5,
//                   child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30)),
//                       child: const Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 30,
//                       )))
//               : Positioned(
//                   right: 4.5,
//                   bottom: 4.5,
//                   child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30)),
//                       child: const Icon(
//                         Icons.error,
//                         color: Color.fromARGB(255, 170, 153, 1),
//                         size: 30,
//                       )))
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfileContainerSection extends StatefulWidget {
  final bool isCompleted;
  final String heading;
  final String subHeading;
  final VoidCallback onTap;
  final Icon icon;

  const ProfileContainerSection({
    super.key,
    required this.isCompleted,
    required this.heading,
    required this.subHeading,
    required this.onTap,
    required this.icon,
  });

  @override
  State<ProfileContainerSection> createState() => _ProfileContainerSectionState();
}

class _ProfileContainerSectionState extends State<ProfileContainerSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOutCubic,
      ),
    );

    _elevationAnimation = Tween<double>(
      begin: 2,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTapDown: (_) => _hoverController.forward(),
                  onTapUp: (_) => _hoverController.reverse(),
                  onTapCancel: () => _hoverController.reverse(),
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: _buildContent(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isCompleted
              ? Colors.green.withOpacity(0.5)
              : Colors.amber.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeading(),
                const SizedBox(height: 4),
                _buildSubheading(),
              ],
            ),
          ),
          _buildCompletionIcon(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
        child: widget.icon,
      ),
    );
  }

  Widget _buildHeading() {
    return Text(
      widget.heading,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubheading() {
    return Text(
      widget.subHeading,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildCompletionIcon() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.isCompleted
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            )
          : const Icon(
              Icons.warning,
              size: 16,
              color: Colors.amber,
            ),
    );
  }
}



