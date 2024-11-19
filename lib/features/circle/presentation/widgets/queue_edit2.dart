import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/queue_bloc/queue_bloc.dart';

class QueueEdit2 extends StatefulWidget {
  const QueueEdit2({super.key});

  @override
  State<QueueEdit2> createState() => _QueueEdit2State();
}

class _QueueEdit2State extends State<QueueEdit2> {
  late TextEditingController _countrySearchController;
  late final TextTheme textTheme;
  @override
  void initState() {
    super.initState();
    _countrySearchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  void dispose() {
    _countrySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const ThemeGap(10),
            leftHeadingWithSub(
                context: context,
                heading: 'Add Interested Countries',
                subHeading: 'Tap to select Countries'),
            const ThemeGap(5),
            Expanded(
                child: ListView(
              children: [countrySelector()],
            ))
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: FloatingActionButton(
              onPressed: () {
                context.read<QueueBloc>().pageController.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (context.read<QueueBloc>().countriesId.isEmpty) {
                showSimpleSnackBar(
                    context: context,
                    text: 'You must select atleast one country',
                    position: SnackBarPosition.BOTTOM,
                    isError: true);
              } else {
                context.read<QueueBloc>().pageController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget countrySelector() {
    return BlocBuilder<QueueBloc, QueueState>(
      builder: (context, state) {
        return Column(
          children: [
            const ThemeGap(10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${context.read<QueueBloc>().countriesId.length} Selected countries',
                  style: textTheme.labelMedium,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                context.read<QueueBloc>().countriesId.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          context.read<QueueBloc>().add(DeSelectAllCountry());
                        },
                        child: Text(
                          'Deselect All',
                          style: textTheme.labelMedium,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          context.read<QueueBloc>().add(SelectAllCountry());
                        },
                        child: Text(
                          'Select All',
                          style: textTheme.labelMedium,
                        ),
                      ),
              ],
            ),
            Wrap(
              children: List.generate(
                  context.read<QueueBloc>().allCountries.length, (index) {
                final data = context.read<QueueBloc>().allCountries[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      if (containsCheck(data) == false) {
                        addCountry(data);
                      } else {
                        addCountry(data);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.3),
                          color: containsCheck(data) == true
                              ? Colors.green
                              : Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          data.name,
                          style: TextStyle(
                              color: containsCheck(data) == true
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        );
      },
    );
  }

  bool containsCheck(CountryModel element) {
    for (var e in context.read<QueueBloc>().countriesId) {
      if (e.id == element.id) {
        return true;
      }
    }
    return false;
  }

  addCountry(CountryModel data) {
    context.read<QueueBloc>().add(SelectCountry(country: data));
  }
}
