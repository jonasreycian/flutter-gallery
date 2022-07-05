import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/curated_photos.dart';
import '../../repositories/photo_repository.dart';

class SearchPhotoUsecase extends UseCase<CuratedPhotos, SearchPhotoUsecaseParams> {
  final PhotoRepository _photoRepository;
  SearchPhotoUsecase(this._photoRepository);

  @override
  Future<Stream<CuratedPhotos?>> buildUseCaseStream(SearchPhotoUsecaseParams? params) async {
    final StreamController<CuratedPhotos?> controller = StreamController();
    try {
      final response = await _photoRepository.searchPhoto(
        params!.query,
        orientation: params.orientation,
        size: params.size,
        color: params.color,
        locale: params.locale,
        page: params.page,
        perPage: params.perPage,
      );

      controller.add(response);
      logger.finest("SearchPhotoUsecase: Successfull!");
      controller.close();
    } catch (e) {
      logger.severe("SearchPhotoUsecase: ${e.toString()}");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class SearchPhotoUsecaseParams {
  final String query;
  final String? orientation;
  final String? size;
  final String? color;
  final String? locale;
  final int? page;
  final int? perPage;

  SearchPhotoUsecaseParams(
    this.query, {
    this.orientation,
    this.size,
    this.color,
    this.locale,
    this.page,
    this.perPage,
  });
}
