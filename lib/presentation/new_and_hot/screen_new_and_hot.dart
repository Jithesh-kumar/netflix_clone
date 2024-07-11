import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/comming_soon_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

import '../../application/hot_and_new/hot_and_new_bloc.dart';
import '../../core/constants.dart';

class ScreenNewandHot extends StatelessWidget {
  const ScreenNewandHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: Text(
              "New & Hot",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
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
              kWidth
            ],
            bottom: TabBar(
                labelColor: kBlackColor,
                unselectedLabelColor: kWhiteColor,
                isScrollable: true,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: kRadius30,
                ),
                tabs: const [
                  Tab(
                    text: '🍿 Comming Soon',
                  ),
                  Tab(
                    text: "👀 Everyone's watching",
                  )
                ]),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingSoonList(
              key: Key('coming_soon'),
            ),
            EveryoneWatchingList(
              key: Key('everyone_is_watching'),
            )
          ],
        ),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(
        const LoadDataInCommingSoon(),
      );
    });
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.hasError) {
          return const Center(
            child: Text('Error while loading Data'),
          );
        } else if (state.comingSoonList.isEmpty) {
          return const Center(
            child: Text('Comming soon list is empty'),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: state.comingSoonList.length,
            itemBuilder: (BuildContext context, index) {
              final movie = state.comingSoonList[index];
              if (movie.id == null) {
                return const SizedBox();
              }

              final _date = DateTime.parse(movie.releaseDate!);
              final formatedDate = DateFormat.yMMMMd('en_US').format(_date);

              return CommingSoonWidget(
                id: movie.id.toString(),
                month:
                    formatedDate.split(' ').first.substring(0, 3).toUpperCase(),
                day: movie.releaseDate!.split('-')[2],
                movieName: movie.originalTitle ?? 'No title',
                posterPath: '$imageAppendUrl${movie.posterPath}',
                description: movie.overview ?? 'No description',
              );
            },
          );
        }
      },
    );
  }
}

class EveryoneWatchingList extends StatelessWidget {
  const EveryoneWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(
        const LoadDataInEveryoneWatching(),
      );
    });
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.hasError) {
          return const Center(
            child: Text('Error while loading Data'),
          );
        } else if (state.everyOneWatchingList.isEmpty) {
          return const Center(
            child: Text('Comming soon list is empty'),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.everyOneWatchingList.length,
            itemBuilder: (BuildContext context, index) {
              final movie = state.everyOneWatchingList[index];
              if (movie.id == null) {
                return const SizedBox();
              }

              final tv = state.everyOneWatchingList[index];
              return EveronesWatchingWidget(
                movieName: tv.originalName ?? 'No Name',
                posterPath: '$imageAppendUrl${tv.posterPath}',
                description: tv.overview ?? 'No description',
              );
            },
          );
        }
      },
    );
  }
}
