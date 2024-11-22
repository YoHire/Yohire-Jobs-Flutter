class AppliedJobEntity {
  final String id;
  final String title;
  final String location;
  final bool isResumeDownloaded;

  AppliedJobEntity(
      {required this.id,
      required this.title,
      required this.location,
      required this.isResumeDownloaded});
}
