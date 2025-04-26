class Constants {
  // Route names
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String newsDetailsScreen = '/newsDetailsScreen';

  // App metadata
  static const String appName = 'Arth.ai';

  // API endpoints
  static const String baseNewsUrl = 'https://newsapi.org/v2/everything';

  // Keys for API requests
  static const String query = 'q';
  static const String apiKey = 'apiKey';
  static const String page = 'page';
  static const String pageSize = 'pageSize';

  // Keys
  static const int successStatusCode = 200;
  static const String statusCode = 'statusCode';
  static const String articles = 'articles';
  static const String newsApiKey = 'NEWS_API_KEY';

  // Database
  static const String dbName = 'search_results';
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
  static const String author = 'author';
  static const String title = 'title';
  static const String description = 'description';
  static const String url = 'url';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';
  static const String content = 'content';
  static const String uniqueId = 'uniqueId';
  static const String id = 'id';
  static const String name = 'name';

  // Other
  static const int maxPixelsCloseToBottom = 100;
  static const String logoPath = 'assets/logo.png';
  static const String emptyImagePath =
      'https://images.unsplash.com/36/fVSwTG05QIaE9FN7tLQ5_IMG_1122.jpg?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  static const String emptyListIllustrationPath = 'assets/empty_list_text.png';
  static const String emptyListMessage =
      'search the news from around the world.';
  static const String searchHint = 'Search for anything and everything.';
}
