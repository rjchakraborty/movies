import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movies/app_config.dart';
import 'package:movies/module/top_movies/provider/top_movies_controller.dart';
import 'package:movies/module/widgets.dart';
import 'package:movies/utils/HexColor.dart';

class TopMoviesPage extends StatefulWidget {
  const TopMoviesPage({super.key});

  @override
  _TopMoviesPageState createState() => _TopMoviesPageState();
}

class _TopMoviesPageState extends State<TopMoviesPage> {
  @override
  void initState() {
    super.initState();
    TopMoviesController.to.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
          child: TopMoviesController.to.movies.value != null &&
                  TopMoviesController.to.movies.value!.movies != null &&
                  TopMoviesController.to.movies.value!.movies!.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: TopMoviesController.to.movies.value!.movies!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return MovieItem(
                      movie: TopMoviesController.to.movies.value!.movies![index],
                      index: index,
                      isDetailsPage: false,
                    );
                  },
                )
              : Container(
                  color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                  child: Center(
                    child: Image.asset('assets/images/loading.gif'),
                  ),
                ),
        ));
  }
}
