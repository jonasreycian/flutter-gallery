import 'package:pexel_copy_demo/domain/entities/curated_photos.dart';
import 'package:pexel_copy_demo/domain/entities/photo.dart';

abstract class PhotoRepository {
  Future<CuratedPhotos?> getCuratedPhotos(int? page, int? perPage);
  Future<Photo> getPhoto(int id);
  Future<CuratedPhotos?> searchPhoto(
    String query, {
    String? orientation,
    String? size,
    String? color,
    String? locale,
    int? page,
    int? perPage,
  });
}
