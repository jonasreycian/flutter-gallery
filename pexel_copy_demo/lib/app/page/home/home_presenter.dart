import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pexel_copy_demo/domain/entities/curated_photos.dart';
import 'package:pexel_copy_demo/domain/repositories/photo_repository.dart';
import 'package:pexel_copy_demo/domain/usecases/photo/get_curated_photos_usecase.dart';

class HomePresenter extends Presenter {
  late Function getCuratedPhotoOnNext;
  late Function getCuratedPhotoOnError;
  late Function getCuratedPhotoOnComplete;

  final GetCuratedPhotosUseCase _getCuratedPhotosUseCase;

  HomePresenter(PhotoRepository photoRepository) : _getCuratedPhotosUseCase = GetCuratedPhotosUseCase(photoRepository);

  @override
  void dispose() {
    _getCuratedPhotosUseCase.dispose();
  }

  void getCuratedPhotos() {
    _getCuratedPhotosUseCase.execute(_GetUserUseCaseObserver(this));
  }
}

class _GetUserUseCaseObserver implements Observer<CuratedPhotos> {
  final HomePresenter _presenter;
  _GetUserUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.getCuratedPhotoOnComplete();
  }

  @override
  void onError(e) {
    _presenter.getCuratedPhotoOnError(e);
  }

  @override
  void onNext(t) {
    assert(t is CuratedPhotos);
    _presenter.getCuratedPhotoOnNext(t);
  }
}
