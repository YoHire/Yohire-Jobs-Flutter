import 'package:flutter/material.dart';

class CustomContainerBuilder extends StatelessWidget {
  final List<ContainerBuilderItem> items;
  final String title;

  const CustomContainerBuilder(
      {super.key, required this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            title,
            style: textTheme.labelMedium,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 2.5, color: const Color(0xFFe3e3e3)),
              color: const Color(0xFFf2f2f2),
              borderRadius: BorderRadius.circular(30)),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return items[index];
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Color(0xFFe3e3e3),
                    thickness: 2.5,
                  ),
                );
              },
              itemCount: items.length),
        ),
      ],
    );
  }
}

class ContainerBuilderItem extends StatelessWidget {
  final Icon icon;
  final void Function()? onTap;
  final String title;

  const ContainerBuilderItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: IconTheme(
          data: const IconThemeData(
            color: Color.fromARGB(255, 66, 65, 65),
            size: 24,
          ),
          child: icon,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      title: Text(
        title,
        style: textTheme.bodyMedium,
      ),
    );
  }
}
