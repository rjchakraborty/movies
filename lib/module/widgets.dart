import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app_config.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/module/base/provider/base_controller.dart';
import 'package:movies/module/details/movie_detail.dart';
import 'package:movies/module/details/provider/movie_detail_controller.dart';
import 'package:movies/module/top_movies/provider/top_movies_controller.dart';
import 'package:movies/utils/CommonUtils.dart';
import 'package:movies/utils/HexColor.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class MovieItem extends StatelessWidget {
  Movie? movie;
  int index = 0;
  bool isDetailsPage = false;
  int? movieID = 0;

  MovieItem({this.movie, this.index = 0, this.isDetailsPage = false, this.movieID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return movie == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
                color: HexColor.getColor(
                    (movie != null && movieID != null && movie!.id != null && movieID == movie!.id) ? PRIMARY_COLOR_HEX : CARD_BACKGROUND_COLOR_HEX),
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Material(
              color: HexColor.getColor(
                  (movie != null && movieID != null && movie!.id != null && movieID == movie!.id) ? PRIMARY_COLOR_HEX : CARD_BACKGROUND_COLOR_HEX),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: InkWell(
                splashColor: HexColor.getColor(PRIMARY_COLOR_HEX),
                customBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                onTap: () {
                  if (BaseController.to.genres.value != null &&
                      BaseController.to.genres.value!.genres != null &&
                      BaseController.to.genres.value!.genres!.isNotEmpty) {
                    MovieDetailController.to.isDetailPage.value = isDetailsPage;
                    MovieDetailController.to.selectedMovie.value = movie;
                    MovieDetailController.to.heroID.value = movie!.id ?? 0;
                    MovieDetailController.to.index.value = index ?? 0;
                    if (!isDetailsPage) {
                      Get.to(const MovieDetailPage(), transition: Transition.rightToLeft);
                    }
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: HexColor.getColor(PRIMARY_COLOR_HEX).withOpacity(.03),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Hero(
                      tag: '${movie!.id}',
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 118,
                            height: 168,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                              child: FadeInImage(
                                image: NetworkImage('${AppConfig.TMDB_BASE_IMAGE_URL}w500/${movie!.posterPath!}'),
                                fit: BoxFit.cover,
                                placeholder: const AssetImage('assets/images/loading.gif'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (!isDetailsPage && index == 0)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/goldmedal_icon.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Top movie this week',
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: Text(
                                    TopMoviesController.to.movies.value!.movies![index].title!,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                if (BaseController.to.genres.value != null &&
                                    BaseController.to.genres.value!.genres != null &&
                                    BaseController.to.genres.value!.genres!.isNotEmpty)
                                  FutureBuilder<List<Genre>>(
                                    future: BaseController.to.getGenreById(TopMoviesController.to.movies.value!.movies![index].genreIds ?? [],
                                        BaseController.to.genres.value!.genres!), // async work
                                    builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
                                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                                        return GenreList(snapshot.data!, Theme.of(context).textTheme.headline6);
                                      }
                                      return Container();
                                    },
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    CommonUtils.getReleaseYear(TopMoviesController.to.movies.value!.movies![index].releaseDate),
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                if (CommonUtils.checkIfNotNull(TopMoviesController.to.movies.value!.movies![index].voteAverage))
                                  RatingBar(voteAverage: CommonUtils.getDouble(TopMoviesController.to.movies.value!.movies![index].voteAverage))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class RatingBar extends StatelessWidget {
  double voteAverage = 0.0;

  RatingBar({this.voteAverage = 0.0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
        decoration: BoxDecoration(color: Colors.white.withOpacity(.08), borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingStars(
              editable: false,
              rating: (voteAverage / 2),
              color: HexColor.getColor('FFB825'),
              iconSize: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                '${(voteAverage / 2)}/5',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ));
  }
}

class GenreList extends StatefulWidget {
  final List<Genre> genreList;
  final TextStyle? textStyle;

  const GenreList(this.genreList, this.textStyle, {super.key});

  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: Center(
          child: widget.genreList == null
              ? const CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.genreList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Text(
                          widget.genreList[index].name ?? '',
                          style: widget.textStyle ?? Theme.of(context).textTheme.headline6,
                        ),
                        if (index != (widget.genreList.length - 1))
                          Text(
                            ' / ',
                            style: widget.textStyle ?? Theme.of(context).textTheme.headline6,
                          )
                      ],
                    );
                  },
                ),
        ));
  }
}
