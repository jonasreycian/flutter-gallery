import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/curated_photos.dart';
import '../../repositories/photo_repository.dart';

class GetCuratedPhotosUseCase extends UseCase<CuratedPhotos, GetCuratedPhotosParams> {
  final PhotoRepository _photoRepository;

  GetCuratedPhotosUseCase(this._photoRepository);

  @override
  Future<Stream<CuratedPhotos?>> buildUseCaseStream(GetCuratedPhotosParams? params) async {
    final StreamController<CuratedPhotos?> controller = StreamController();
    try {
      final response = await _photoRepository.getCuratedPhotos(params?.page, params?.perPage);

      controller.add(response);

      logger.finest("GetCuratedPhotosUseCase: Successfull!");
      controller.close();
    } catch (e) {
      logger.severe("GetCuratedPhotosUseCase: ${e.toString()}");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetCuratedPhotosParams {
  final int? page;
  final int? perPage;

  GetCuratedPhotosParams(this.page, this.perPage);
}
