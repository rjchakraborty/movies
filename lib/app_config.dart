library constants;

const int API_ERROR_CODE = 5052;
const int API_TIMEOUT_CODE = 5053;

const String IN_PROGRESS = 'in_progress';
const String PENDING = 'pending';
const String COMPLETED = 'completed';

const String NULL = 'null';

const String FONT_LIGHT = 'GorditaLight';
const String FONT_REGULAR = 'GorditaRegular';
const String FONT_BOLD = 'GorditaBold';
const String FONT_MEDIUM = 'GorditaMedium';

const String PRIMARY_COLOR_HEX = "007CFF";
const String PRIMARY_LIGHT_COLOR_HEX = "00bcff";
const String PRIMARY_DARK_COLOR_HEX = "070818";
const String PRIMARY_ACCENT_COLOR_HEX = "FFFFFF";
const String CARD_BACKGROUND_COLOR_HEX = "1B1C2A";
const String TINT_ACCENT_COLOR_HEX = "FFA000";
const String DARK_ERROR_COLOR_HEX = "580000";

const String PENDING_COLOR_HEX = "#D9D93A";
const String COMPLETED_COLOR_HEX = "#128235";
const String PROGRESS_COLOR_HEX = "#F8A12F";
const String DARK_GREY_COLOR_HEX = "#525252";

const String somethingWrong = "Something Went Wrong";
const String responseMessage = "NO RESPONSE DATA FOUND";
const String interNetMessage = "NO INTERNET CONNECTION, PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN LATTER.";
const String connectionTimeOutMessage = "Server not working or might be in maintenance .Please Try Again Later";
const String authenticationMessage = "The session has been Expired. Please log in again.";
const String tryAgain = "Try Again";

class AppConfig {
  static String TMDB_API_BASE_URL = "https://api.themoviedb.org/3";
  static String TMDB_API_KEY = "YOUR_API_KEY";
  static String TMDB_BASE_IMAGE_URL = "https://image.tmdb.org/t/p/";

  static String discoverMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/discover/movie?api_key='
        '$TMDB_API_KEY'
        '&language=en-US&sort_by=popularity'
        '.desc&include_adult=false&include_video=false&page'
        '=$page';
  }

  static String nowPlayingMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/now_playing?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String getCreditsUrl(int id) {
    return '$TMDB_API_BASE_URL' + '/movie/$id/credits?api_key=$TMDB_API_KEY';
  }

  static String topRatedUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/top_rated?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String popularMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/popular?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String upcomingMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/upcoming?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String movieDetailsUrl(int movieId) {
    return '$TMDB_API_BASE_URL/movie/$movieId?api_key=$TMDB_API_KEY&append_to_response=credits,'
        'images';
  }

  static String genresUrl() {
    return '$TMDB_API_BASE_URL/genre/movie/list?api_key=$TMDB_API_KEY&language=en-US';
  }

  static String getMoviesForGenre(int genreId, int page) {
    return '$TMDB_API_BASE_URL/discover/movie?api_key=$TMDB_API_KEY'
        '&language=en-US'
        '&sort_by=popularity.desc'
        '&include_adult=false'
        '&include_video=false'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static String movieReviewsUrl(int movieId, int page) {
    return '$TMDB_API_BASE_URL/movie/$movieId/reviews?api_key=$TMDB_API_KEY'
        '&language=en-US&page=$page';
  }

  static String movieSearchUrl(String query) {
    return "$TMDB_API_BASE_URL/search/movie?query=$query&api_key=$TMDB_API_KEY";
  }

  static String personSearchUrl(String query) {
    return "$TMDB_API_BASE_URL/search/person?query=$query&api_key=$TMDB_API_KEY";
  }

  static getPerson(int personId) {
    return "$TMDB_API_BASE_URL/person/$personId?api_key=$TMDB_API_KEY&append_to_response=movie_credits";
  }
}
