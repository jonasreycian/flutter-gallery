class DataConstants {
  // API Endpoints
  static const String _baseUrl = 'https://api.pexels.com/v1';
  static const String _videoBaseUrl = 'https://www.pexels.com/videos/';

  // API Keys
  static const _apiKey = "YOUR_API_KEY";

  // Photos endpoint
  static String get curatedPhotosUrl => '$_baseUrl/curated/';
  static String get getPhotoUrl => '$_baseUrl/photos/';
  static String get searchPhotoUrl => '$_baseUrl/search/';

  // Videos endpoint
  static String get curatedVideosUrl => '$_videoBaseUrl/videos';

  static Map<String, String> coreHeader = {
    'Authorization': _apiKey,
  };
}
