import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/curated_photos.dart';
import '../../../domain/repositories/photo_repository.dart';
import '../../utils/constant.dart';
import 'home_presenter.dart';

class HomeController extends Controller {
  final HomePresenter _homePresenter;
  late CuratedPhotos _curatedPhotos;
  late bool isLoading;

  HomeController(PhotoRepository photoRepository)
      : _homePresenter = HomePresenter(photoRepository),
        isLoading = false {
    _homePresenter.getCuratedPhotos();
  }

  @override
  void initListeners() {
    _homePresenter.getCuratedPhotoOnNext = (CuratedPhotos curatedPhotos) {
      _curatedPhotos = curatedPhotos;
    };

    _homePresenter.getCuratedPhotoOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.toString(), isError: true);
    };

    _homePresenter.getCuratedPhotoOnComplete = () {
      dismissLoading();
    };
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  @override
  void dispose() {
    _homePresenter.dispose();
    super.dispose();
  }
}
