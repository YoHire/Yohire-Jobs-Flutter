import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openbn/core/utils/shared_services/models/user/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/profile/presentation/widgets/profile_image_changer.dart';
import 'package:openbn/init_dependencies.dart';

class ProfileTileWidget extends StatefulWidget {
  const ProfileTileWidget({super.key});

  @override
  State<ProfileTileWidget> createState() => _ProfileTileWidgetState();
}

class _ProfileTileWidgetState extends State<ProfileTileWidget> {
  late Box myBox;
  late Stream<BoxEvent> boxStream;
  String username = '';
  String surname = '';
  String email = '';
  String? imageUrl;
  final storage = serviceLocator<GetStorage>();

  @override
  void initState() {
    if (storage.read('isLogged') != null) {
      _assignAllData(serviceLocator<UserStorageService>().getUser()!);
      _hiveListener();
    }
    super.initState();
  }

  void _hiveListener() {
    myBox = Hive.box<UserModel>('userBox');
    boxStream = myBox.watch();
    boxStream.listen((event) {
      UserModel data = event.value;
      _assignAllData(data);
    });
  }

  _assignAllData(UserModel data) {
    username = data.username ?? '';
    surname = data.surname ?? '';
    email = data.email ?? '';
    imageUrl = data.profileImage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ThemeGap(20),
        ProfileImageWidget(
          existingImageUrl: imageUrl,
        ),
        const ThemeGap(10),
        Text(
          '$username $surname',
          style: textTheme.titleMedium,
        ),
        Text(
          email,
          style: textTheme.labelMedium,
        ),
      ],
    );
  }
}
