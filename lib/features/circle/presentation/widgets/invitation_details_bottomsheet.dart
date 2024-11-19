import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/description_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:openbn/features/circle/presentation/widgets/company_invite_tile.dart';
import 'package:openbn/features/circle/presentation/widgets/select_data_widget.dart';

class InvitationDetailsBottomsheet extends StatelessWidget {
  final int index;
  const InvitationDetailsBottomsheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationBloc, InvitationState>(
      builder: (context, state) {
        if (state is InvitationLoaded) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                CompanyInviteTile(
                  data: state.data[index],
                  subHeading: 'Tap for more info',
                ),
                DescriptionHeadingWidget(
                    isCenteredHeading: true,
                    heading: state.data[index].invitedJob!.jobTitle,
                    description: state.data[index].invitedJob!.description),
                const ThemeGap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ThemedButton(
                      text: 'Reject',
                      loading: false,
                      onPressed: () {},
                      color: Colors.red,
                    ),
                    ThemedButton(
                      text: 'Accept',
                      loading: false,
                      onPressed: () {
                        _showSelectDataWidget(context: context);
                      },
                      color: Colors.green,
                    ),
                  ],
                ),
                const ThemeGap(50),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // Bottom sheets
  void _showSelectDataWidget({required BuildContext context}) {
    Navigator.of(context).pop();
    showCustomBottomSheet(
      heightFactor: 0.60,
      context: context,
      content: const SelectDataWidget(),
      isScrollControlled: true,
      isScrollable: true,
    );
  }
}
