// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_app/application/home/home_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';

import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/home/widgets/background_card_widget.dart';

import 'package:netflix_app/presentation/home/widgets/number_title_card.dart';

import '../widgets/main_title__card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        const GetHomeScreenData(),
      );
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              //print(direction);
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.hasError) {
                      return Center(
                        child: Text(
                          'Error while getting data',
                          style: GoogleFonts.montserrat(
                            color: kWhiteColor,
                          ),
                        ),
                      );
                    }

                    final _realeasedPastYear = state.pastYearMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _realeasedPastYear.shuffle();
                    final _trendingNow = state.trendingMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _trendingNow.shuffle();
                    final _tense = state.tenseDrammNovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _tense.shuffle();
                    final _southIndianCinema =
                        state.southIndianMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _southIndianCinema.shuffle();
                    print(state.trendingTvList.length);

                    //top 10 tv shows

                    final _top10Tvshow = state.trendingTvList.map((t) {
                      return '$imageAppendUrl${t.posterPath}';
                    }).toList();
                    return ListView(
                      children: [
                        const BackGroundCard(),
                        MainTitleCard(
                          title: 'Released in the past year',
                          posterList: _realeasedPastYear.take(10).toList(),
                        ),
                        kHight,
                        MainTitleCard(
                          title: 'Trending Now',
                          posterList: _trendingNow.take(10).toList(),
                        ),
                        kHight,
                        NumberTitleCard(
                          postersList: _top10Tvshow.take(10).toList(),
                        ),
                        kHight,
                        MainTitleCard(
                          title: 'Tense Dramas',
                          posterList: _tense.take(10).toList(),
                        ),
                        kHight,
                        MainTitleCard(
                          title: 'South Indian Cinema',
                          posterList: _southIndianCinema.take(10).toList(),
                        ),
                        kHight,
                      ],
                    );
                  },
                ),
                scrollNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Image.asset(
                                      'assets/images/icon.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    backgroundColor: kBlackColor,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kWidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                kWidth,
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'TV Shows',
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  'Movies',
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  'Categories',
                                  style: kHomeTitleText,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : kHight
              ],
            ),
          );
        },
      ),
    );
  }
}

/**
  NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          print(direction);
          if (direction == ScrollDirection.reverse) {
            scrollNotifier.value = false;
          } else if (direction == ScrollDirection.forward) {
            scrollNotifier.value = true;
          }
          return true;
        },
        child: ListView(
          children: const [
            BackGroundCard(),
            MainTitleCard(
              title: 'Released in the past year',
            ),
            kHight,
            MainTitleCard(
              title: 'Trending Now',
            ),
            kHight,
            NumberTitleCard(),
            kHight,
            MainTitleCard(
              title: 'Tense Dramas',
            ),
            kHight,
            MainTitleCard(
              title: 'South Indian Cinema',
            ),
            kHight,
          ],
        ),
      ),
 */
