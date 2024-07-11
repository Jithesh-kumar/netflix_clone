// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:netflix_app/presentation/home/widgets/number_card.dart';

import '../../../core/constants.dart';
import '../../widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
    required this.postersList,
  }) : super(key: key);
  final List<String> postersList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(title: 'Top 10 Tv Shows In India Today'),
        kHight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                postersList.length,
                (index) => NumberCard(
                      index: index,
                      imageUrl: postersList[index],
                    )),
          ),
        )
      ],
    );
  }
}
