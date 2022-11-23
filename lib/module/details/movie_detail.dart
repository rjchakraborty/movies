import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:movies/app_config.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/module/base/provider/base_controller.dart';
import 'package:movies/module/details/provider/movie_detail_controller.dart';
import 'package:movies/module/top_movies/provider/top_movies_controller.dart';
import 'package:movies/module/widgets.dart';
import 'package:movies/utils/CommonUtils.dart';
import 'package:movies/utils/HexColor.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: MovieDetailController.to.heroID,
                      child: Stack(
                        children: <Widget>[
                          MovieDetailController.to.selectedMovie.value != null && MovieDetailController.to.selectedMovie.value!.posterPath == null
                              ? Image.asset(
                                  'assets/images/na.jpg',
                                  fit: BoxFit.cover,
                                )
                              : FadeInImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  image: NetworkImage(
                                      '${AppConfig.TMDB_BASE_IMAGE_URL}original/${MovieDetailController.to.selectedMovie.value!.posterPath!}'),
                                  fit: BoxFit.cover,
                                  placeholder: const AssetImage('assets/images/loading.gif'),
                                ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                gradient: LinearGradient(begin: FractionalOffset.bottomCenter, end: FractionalOffset.topCenter, colors: [
                                  HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                                  HexColor.getColor(PRIMARY_DARK_COLOR_HEX).withOpacity(0.3),
                                  HexColor.getColor(PRIMARY_DARK_COLOR_HEX).withOpacity(0.2),
                                  HexColor.getColor(PRIMARY_DARK_COLOR_HEX).withOpacity(0.1),
                                ], stops: const [
                                  0.0,
                                  0.5,
                                  0.75,
                                  0.9
                                ])),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          if (MovieDetailController.to.index.value == 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Top movie of the week',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (MovieDetailController.to.index.value == 0)
                                    ? Image.asset(
                                        'assets/images/goldmedal_icon.png',
                                        width: 31,
                                        height: 38,
                                      )
                                    : const SizedBox(
                                        width: 31,
                                        height: 38,
                                      ),
                                Container(
                                  width: Get.width * 0.75,
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    MovieDetailController.to.selectedMovie.value!.title ?? '',
                                    style: Theme.of(context).textTheme.headline1,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(58, 1, 24, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      CommonUtils.getReleaseYear(MovieDetailController.to.selectedMovie.value!.releaseDate),
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    Text(
                                      ' • ',
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    if (BaseController.to.genres.value != null &&
                                        BaseController.to.genres.value!.genres != null &&
                                        BaseController.to.genres.value!.genres!.isNotEmpty)
                                      FutureBuilder<List<Genre>>(
                                        future: BaseController.to.getGenreById(
                                            MovieDetailController.to.selectedMovie.value!.genreIds ?? [], BaseController.to.genres.value!.genres!),
                                        // async work
                                        builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
                                          if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                                            return GenreList(snapshot.data!, Theme.of(context).textTheme.headline5);
                                          }
                                          return Container();
                                        },
                                      ),
                                  ],
                                ),
                                if (CommonUtils.checkIfNotNull(MovieDetailController.to.selectedMovie.value!.overview))
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text(
                                      MovieDetailController.to.selectedMovie.value!.overview!,
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                if (CommonUtils.checkIfNotNull(MovieDetailController.to.selectedMovie.value!.voteAverage))
                                  Container(
                                      width: Get.width * 0.4,
                                      padding: const EdgeInsets.only(top: 16),
                                      child: RatingBar(voteAverage: CommonUtils.getDouble(MovieDetailController.to.selectedMovie.value!.voteAverage)))
                              ],
                            ),
                          ),
                          Container(
                            width: Get.width * 0.75,
                            padding: const EdgeInsets.only(left: 18.24, top: 40),
                            child: Text(
                              'Also trending',
                              style: Theme.of(context).textTheme.headline2,
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                            padding: const EdgeInsets.only(top: 16),
                            child: TopMoviesController.to.movies.value != null &&
                                    TopMoviesController.to.movies.value!.movies != null &&
                                    TopMoviesController.to.movies.value!.movies!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: TopMoviesController.to.movies.value!.movies!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int index) {
                                      return MovieItem(
                                        movie: TopMoviesController.to.movies.value!.movies![index],
                                        index: index,
                                        isDetailsPage: MovieDetailController.to.isDetailPage.value,
                                        movieID: MovieDetailController.to.selectedMovie.value!.id,
                                      );
                                    },
                                  )
                                : Container(
                                    color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                                    child: Center(
                                      child: Image.asset('assets/images/loading.gif'),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
