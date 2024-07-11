// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class CommingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String movieName;
  final String posterPath;
  final String description;

  const CommingSoonWidget({
    Key? key,
    required this.id,
    required this.month,
    required this.day,
    required this.movieName,
    required this.posterPath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                month,
                style: TextStyle(fontSize: 16, color: kGreyColor),
              ),
              Text(
                day,
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(
                image: posterPath,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //const Spacer(),
                  const CustomButtonWidget(
                    icon: Icons.notifications_none_sharp,
                    title: "Remind me",
                    iconSize: 20,
                    textSize: 16,
                  ),
                  kWidth,
                  const CustomButtonWidget(
                    icon: Icons.info,
                    title: "Info",
                    iconSize: 20,
                    textSize: 16,
                  ),
                ],
              ),
              kHight,
              Text(
                "Comming on $day $month",
                style: GoogleFonts.montserrat(),
              ),
              kHight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              kHight,
              Text(
                description,
                maxLines: 4,
                style: GoogleFonts.montserrat(
                  color: kGreyColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
