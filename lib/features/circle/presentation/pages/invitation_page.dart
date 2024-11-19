import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/bottom_sheets/bottomsheet.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/placeholders.dart';
import 'package:openbn/features/circle/presentation/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:openbn/features/circle/presentation/widgets/company_invite_tile.dart';
import 'package:openbn/features/circle/presentation/widgets/invitation_details_bottomsheet.dart';

class InvitationPage extends StatefulWidget {
  final String queueId;

  const InvitationPage({super.key, required this.queueId});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  // Constants
  static const double _padding = 15.0;
  static const double _dividerThickness = 0.1;
  static const double _bottomSheetHeightFactor = 0.5;

  // Text constants
  static const String _pageTitle = 'Your Invitations';
  static const String _pageSubtitle =
      'You can accept or reject invitations based on your interests and by reviewing the company details.';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context
            .read<InvitationBloc>()
            .add(FetchInvitation(queueId: widget.queueId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return customAppBar(context: context);
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            _buildHeader(),
            _buildInvitationsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return leftHeadingWithSub(
      context: context,
      heading: _pageTitle,
      subHeading: _pageSubtitle,
    );
  }

  Widget _buildInvitationsList() {
    return BlocBuilder<InvitationBloc, InvitationState>(
      builder: (context, state) {
        if (state is InvitationLoaded) {
          return _buildLoadedList(state);
        } else if (state is InvitationEmpty) {
          return AnimatedPlaceholders(
              text: 'No invitations yet',
              subText:
                  '''Sit back and relax we'll notify you whenever you receive an invitation''',
              isError: false);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoadedList(InvitationLoaded state) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) => const Divider(
          thickness: _dividerThickness,
        ),
        itemCount: state.data.length,
        itemBuilder: (context, index) => _buildInvitationTile(state, index),
      ),
    );
  }

  Widget _buildInvitationTile(InvitationLoaded state, int index) {
    return CompanyInviteTile(
      onTap: () => _showInvitationDetails(context: context, index: index),
      data: state.data[index],
    );
  }

  void _showInvitationDetails({
    required BuildContext context,
    required int index,
  }) {
    final invitationBloc = BlocProvider.of<InvitationBloc>(context);

    showCustomBottomSheet(
      heightFactor: _bottomSheetHeightFactor,
      context: context,
      content: BlocProvider.value(
        value: invitationBloc,
        child: InvitationDetailsBottomsheet(
          index: index,
        ),
      ),
      isScrollControlled: true,
      isScrollable: true,
    );
  }
}
