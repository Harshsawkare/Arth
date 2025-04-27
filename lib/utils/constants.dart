class Constants {
  // Route names
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String newsDetailsScreen = '/newsDetailsScreen';

  // App metadata
  static const String appName = 'Arth.ai';

  // API endpoints
  static const String baseNewsUrl = 'https://newsdata.io/api/1/latest';
  static const String http = 'http';
  static const String https = 'https';

  // Keys for API requests
  static const String query = 'qInTitle';
  static const String apiKey = 'apikey';
  static const String page = 'page';
  static const String image = 'image';
  static const String nextPage = 'nextPage';
  static const String removeDuplicate ='removeduplicate';
  static const String language ='language';

  // Keys
  static const int successStatusCode = 200;
  static const String statusCode = 'statusCode';
  static const String results = 'results';
  static const String newsApiKey = 'NEWS_API_KEY';

  // values
  static const int intTrue = 1;
  static const int intFalse = 0;
  static const String en = 'en';

  // Database
  static const String articlesDbName = 'articles_db';
  static const String envFileName = '.env';
  static const int maxSearchKeyLimit = 5;
  static const int maxSearchArticleLimit = 10;

  // Exception messages
  static const String errorFetchingNews = 'Error fetching news:';
  static const String keyNotFound = 'API key not found in .env file';

  // Snack-bar messages
  static const String failedToFetchNews = 'Failed to fetch news';
  static const String somethingWentWrong =
      'Something went wrong. Please try again later.';
  static const String invalidSearchTextTitle = 'Invalid search text';
  static const String invalidSearchTextMessage = 'Please enter a valid data.';
  static const String noConnectionTitle = 'No Internet connection';
  static const String noConnectionMessage =
      'You can try checking your internet connection or get the recent new based on your search history.';

  // Theme constants
  static const String isDarkMode = 'isDarkMode';

  // Model keys
  static const String source = 'source';
  static const String creator = 'creator';
  static const String title = 'title';
  static const String description = 'description';
  static const String link = 'link';
  static const String imageUrl = 'image_url';
  static const String pubDate = 'pubDate';
  static const String content = 'content';
  static const String articleId = 'article_id';
  static const String sourceId = 'source_id';
  static const String sourceName = 'source_name';

  // Date constants
  static const String jan = 'Jan';
  static const String feb = 'Feb';
  static const String mar = 'Mar';
  static const String apr = 'Apr';
  static const String may = 'May';
  static const String jun = 'Jun';
  static const String jul = 'Jul';
  static const String aug = 'Aug';
  static const String sep = 'Sep';
  static const String oct = 'Oct';
  static const String nov = 'Nov';
  static const String dec = 'Dec';

  // Other
  static const int maxPixelsCloseToBottom = 100;
  static const String viewDetails = 'View Details';
  static const String logoPath = 'assets/logo.png';
  static const String emptyImagePath =
      'https://images.unsplash.com/36/fVSwTG05QIaE9FN7tLQ5_IMG_1122.jpg?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  static const String emptyListIllustrationPath = 'assets/empty_list_text.png';
  static const String emptyListTitle =
      'No latest news found';
  static const String emptyListMessage =
      'Try searching for latest events from around the world.';
  static const String searchHint = 'Search for anything and everything.';
}
