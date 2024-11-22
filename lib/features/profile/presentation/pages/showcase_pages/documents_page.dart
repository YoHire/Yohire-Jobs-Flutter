import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/app_bar.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:openbn/features/profile/presentation/widgets/document_container.dart';
import 'package:openbn/init_dependencies.dart';

class DocumentsShowcase extends StatefulWidget {
  const DocumentsShowcase({super.key});

  @override
  State<DocumentsShowcase> createState() => _DocumentsShowcaseState();
}

class _DocumentsShowcaseState extends State<DocumentsShowcase> {
  final List<DocumentModel> _allDocuments = [];
  String? _resumeUrl;

  @override
  void initState() {
    _assignAllData();
    super.initState();
  }

  _assignAllData() async {
    final ref = serviceLocator<UserStorageService>();
    await ref.updateUser();
    final data = ref.getUser();
    _allDocuments.clear();
    _allDocuments.addAll(data!.documents);
    _resumeUrl = data.resume!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is DocumentUpdateSuccess) {
          _assignAllData();
        }
      },
      child: Scaffold(
        appBar: customAppBar(context: context, title: 'Documents'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Resume Container
                DocumentContainer(
                  isResume: true,
                  isAdd: false,
                  data: DocumentModel(
                      id: '', name: 'Resume', link: _resumeUrl ?? ''),
                ),

                if (_allDocuments.isNotEmpty) const ThemeGap(20),

                // Documents List
                if (_allDocuments.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _allDocuments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index == _allDocuments.length - 1 ? 0 : 10),
                        child: DocumentContainer(
                          isAdd: false,
                          data: _allDocuments[index],
                        ),
                      );
                    },
                  ),

                const ThemeGap(20),

                // Add button
                DocumentContainer(isAdd: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
