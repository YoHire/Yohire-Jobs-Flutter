import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/usecase/usecase.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';

class UpdateDocumentUsecase implements Usecase<void, UpdateDocumentParams> {
  final ProfileRepository profileRepository;

  UpdateDocumentUsecase(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await profileRepository.updateDocument(document: params.model,progressTracker: params.progressTracker,file: params.file);
  }
}

class UpdateDocumentParams{
  final DocumentModel model;
  final ValueNotifier<double> progressTracker;
  final File file;

  UpdateDocumentParams({required this.model, required this.progressTracker, required this.file});
}
