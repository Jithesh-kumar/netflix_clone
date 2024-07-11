import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import 'custom_button_widget.dart';

class BackGroundCard extends StatelessWidget {
  const BackGroundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //margin: EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                kMainIamge,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomButtonWidget(icon: Icons.add, title: 'My List'),
                _PlayButton(),
                const CustomButtonWidget(icon: Icons.info, title: 'Info'),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// ignore: non_constant_identifier_names
TextButton _PlayButton() {
  return TextButton.icon(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kWhiteColor),
    ),
    icon: const Icon(
      Icons.play_arrow,
      size: 25,
      color: kBlackColor,
    ),
    label: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'Play',
        style: TextStyle(
          fontSize: 20,
          color: kBlackColor,
        ),
      ),
    ),
  );
}
