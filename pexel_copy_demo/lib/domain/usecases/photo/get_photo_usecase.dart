import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/photo.dart';
import '../../repositories/photo_repository.dart';

class GetPhotoUsecase extends UseCase<Photo, int> {
  final PhotoRepository _photoRepository;

  GetPhotoUsecase(this._photoRepository);

  @override
  Future<Stream<Photo?>> buildUseCaseStream(int? params) async {
    final StreamController<Photo> controller = StreamController();
    try {
      final response = await _photoRepository.getPhoto(params!);

      controller.add(response);

      logger.finest("GetPhotoUsecase: Successfull!");
      controller.close();
    } catch (e) {
      controller.addError(e);
      logger.severe("GetPhotoUsecase: ${e.toString()}");
    }
    return controller.stream;
  }
}

class GetPhotoUsecaseParams {
  final int id;

  GetPhotoUsecaseParams(this.id);
}
