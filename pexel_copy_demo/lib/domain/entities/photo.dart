import 'package:equatable/equatable.dart';

import 'photo_source.dart';

class Photo extends Equatable {
  final int id;
  final int width;
  final int height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? averageColor;
  final PhotoSource? source;
  final bool? liked;
  final String? alt;

  const Photo({
    required this.id,
    required this.width,
    required this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.averageColor,
    this.source,
    this.liked,
    this.alt,
  });

  const Photo.empty()
      : id = 0,
        width = 0,
        height = 0,
        url = "",
        photographer = "",
        photographerUrl = "",
        photographerId = 0,
        averageColor = "",
        source = const PhotoSource.empty(),
        liked = false,
        alt = "";

  Photo.from(Photo photo)
      : id = photo.id,
        width = photo.width,
        height = photo.height,
        url = photo.url,
        photographer = photo.photographer,
        photographerUrl = photo.photographerUrl,
        photographerId = photo.photographerId,
        averageColor = photo.averageColor,
        source = photo.source,
        liked = photo.liked,
        alt = photo.alt;

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        width = json['width'] as int,
        height = json['height'] as int,
        url = json['url'] as String,
        photographer = json['photographer'] as String,
        photographerUrl = json['photographer_url'] as String,
        photographerId = json['photographer_id'] as int,
        averageColor = json['average_color'] as String,
        source = json['src'] != null ? PhotoSource.fromJson(json['src']) : const PhotoSource.empty(),
        liked = json['liked'] as bool,
        alt = json['alt'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'average_color': averageColor,
        'src': source?.toJson(),
        'liked': liked,
        'alt': alt,
      };

  @override
  List<Object?> get props => [id, width, height, url, photographer, photographerUrl, photographerId, averageColor, source, liked, alt];
}
