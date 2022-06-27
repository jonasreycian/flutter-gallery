import 'package:logging/logging.dart' show Logger;

import '../../domain/entities/curated_photos.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../utils/constants.dart';
import '../utils/http_helper.dart';

class DataPhotoRepository implements PhotoRepository {
  late Logger _logger;
  late Photo? _photo;
  late CuratedPhotos? _curatedPhotos;
  static final DataPhotoRepository _instance = DataPhotoRepository._internal();

  // Constructor
  DataPhotoRepository._internal() {
    _logger = Logger('DataPhotoRepository');
    _photo = null;
    _curatedPhotos = null;
  }

  factory DataPhotoRepository() => _instance;
  CuratedPhotos? get photos => _curatedPhotos;
  Photo? get photo => _photo;

  @override
  Future<CuratedPhotos?> getCuratedPhotos(int? page, int? perPage) async {
    try {
      if (_curatedPhotos != null && _curatedPhotos?.page == page) {
        _logger.finest("getCuratedPhotos: Successful fetch from cached.");
        return _curatedPhotos;
      }

      String url = DataConstants.curatedPhotosUrl;
      List<String> params = [];

      if (page != null) params.add('page=$page');
      if (perPage != null) params.add('&per_page=$perPage');

      if (params.isNotEmpty) {
        url += "?${params.join('&')}";
      }

      Map<String, dynamic> response = await HttpHelper.invokeHttp(url, RequestType.get, headers: {...DataConstants.coreHeader});
      _curatedPhotos = CuratedPhotos.fromJson(response);
      _logger.finest("getCuratedPhotos: successfull!");
      return _curatedPhotos;
    } catch (e) {
      _logger.severe("getCuratedPhotos: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Photo> getPhoto(int id) async {
    try {
      if (_photo != null && _photo?.id == id) {
        _logger.finest("getPhoto: Successful local fetch!");
        return Future.value(_photo);
      }
      if (_curatedPhotos != null && _curatedPhotos?.photos != null) {
        _photo = _curatedPhotos?.photos.firstWhere((photo) => photo.id == id);
        _logger.finest("getPhoto: Successful remote fetch!");
        return Future.value(_photo);
      }

      final url = '${DataConstants.getPhotoUrl}$id';
      Map<String, dynamic> response = await HttpHelper.invokeHttp(url, RequestType.get, headers: {...DataConstants.coreHeader});
      _photo = Photo.fromJson(response);
      _logger.finest("getPhoto: Successful api fetch!");
      return Future.value(_photo);
    } catch (e) {
      _logger.severe("getPhoto: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<CuratedPhotos?> searchPhoto(
    String query, {
    String? orientation,
    String? size,
    String? color,
    String? locale,
    int? page,
    int? perPage,
  }) async {
    try {
      if (query.isEmpty) throw Exception("Query is empty!");

      String url = DataConstants.searchPhotoUrl;
      List<String> params = [];

      if (orientation != null) params.add('orientation=$orientation');
      if (size != null) params.add('size=$size');
      if (color != null) params.add('color=$color');
      if (locale != null) params.add('locale=$locale');
      if (page != null) params.add('page=$page');
      if (perPage != null) params.add('per_page=$perPage');

      url += '?${params.join('&')}';

      Map<String, dynamic> response = await HttpHelper.invokeHttp(url, RequestType.get, headers: {...DataConstants.coreHeader});
      _curatedPhotos = CuratedPhotos.fromJson(response);
      _logger.finest("searchPhoto: successfull!");
      return Future.value(_curatedPhotos);
    } catch (e) {
      _logger.severe("searchPhoto: ${e.toString()}");
      rethrow;
    }
  }
}
