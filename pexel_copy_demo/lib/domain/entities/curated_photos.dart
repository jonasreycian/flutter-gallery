import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'photo.dart';

class CuratedPhotos extends Equatable {
  final List<Photo> photos;
  final int page;
  final int perPage;
  final int totalResults;
  final String? prevPage;
  final String? nextPage;

  @override
  List<Object?> get props => [photos, page, perPage, totalResults, prevPage, nextPage];

  const CuratedPhotos(
    this.photos,
    this.page,
    this.perPage,
    this.totalResults, {
    this.prevPage,
    this.nextPage,
  });

  CuratedPhotos.empty()
      : photos = [],
        page = 0,
        perPage = 0,
        totalResults = 0,
        prevPage = null,
        nextPage = null;

  CuratedPhotos.from(CuratedPhotos curatedPhoto)
      : photos = curatedPhoto.photos,
        page = curatedPhoto.page,
        perPage = curatedPhoto.perPage,
        totalResults = curatedPhoto.totalResults,
        prevPage = curatedPhoto.prevPage,
        nextPage = curatedPhoto.nextPage;

  CuratedPhotos.fromJson(Map<String, dynamic> json)
      : photos = (json['photos'] as List<dynamic>).map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList(),
        page = json['page'] as int,
        perPage = json['per_page'] as int,
        totalResults = json['total_results'] as int,
        prevPage = json['prev_page'],
        nextPage = json['next_page'];

  Map<String, dynamic> toJson() => {
        'photos': photos.map((e) => e.toJson()).toList(),
        'page': page,
        'per_page': perPage,
        'total_results': totalResults,
        'prev_page': prevPage,
        'next_page': nextPage,
      };
}
