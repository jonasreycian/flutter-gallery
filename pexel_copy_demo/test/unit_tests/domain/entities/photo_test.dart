import 'package:flutter_test/flutter_test.dart';
import 'package:pexel_copy_demo/domain/entities/photo.dart';
import 'package:pexel_copy_demo/domain/entities/photo_source.dart';

void main() {
  group("Entity Testing: Photo", () {
    late Photo emptyPhoto;
    late Photo photoFromJson;
    late Photo photoFromEntity;
    late Map<String, dynamic> jsonValue;

    const String baseUrl = 'https://images.pexels.com/photos';

    setUp(() {
      emptyPhoto = const Photo.empty();
      photoFromJson = Photo.fromJson(const {
        'id': 1,
        'width': 1,
        'height': 1,
        'url': '$baseUrl/original',
        'photographer': 'Photographer',
        'photographer_url': 'https://www.pexels.com/@photographer',
        'photographer_id': 1,
        'src': {
          'portrait': '$baseUrl/portrait',
          'small': '$baseUrl/small',
          'medium': '$baseUrl/medium',
          'large': '$baseUrl/large',
          'original': '$baseUrl/original',
          'large2x': '$baseUrl/large2x',
          'tiny': '$baseUrl/tiny',
          'landscape': '$baseUrl/landscape',
        },
        'average_color': "#978E82",
        'liked': false,
        'alt': 'Brown Rocks During Golden Hour',
      });

      photoFromEntity = const Photo(
        id: 1,
        width: 1,
        height: 1,
        url: '$baseUrl/original',
        photographer: 'Photographer',
        photographerUrl: 'https://www.pexels.com/@photographer',
        photographerId: 1,
        source: PhotoSource(
          portrait: '$baseUrl/portrait',
          small: '$baseUrl/small',
          medium: '$baseUrl/medium',
          large: '$baseUrl/large',
          original: '$baseUrl/original',
          large2x: '$baseUrl/large2x',
          tiny: '$baseUrl/tiny',
          landscape: '$baseUrl/landscape',
        ),
        averageColor: "#978E82",
        liked: false,
        alt: 'Brown Rocks During Golden Hour',
      );

      jsonValue = <String, dynamic>{
        'id': 1,
        'width': 1,
        'height': 1,
        'url': '$baseUrl/original',
        'photographer': 'Photographer',
        'photographer_url': 'https://www.pexels.com/@photographer',
        'photographer_id': 1,
        'src': <String, String>{
          'portrait': '$baseUrl/portrait',
          'small': '$baseUrl/small',
          'medium': '$baseUrl/medium',
          'large': '$baseUrl/large',
          'original': '$baseUrl/original',
          'large2x': '$baseUrl/large2x',
          'tiny': '$baseUrl/tiny',
          'landscape': '$baseUrl/landscape',
        },
        'average_color': "#978E82",
        'liked': false,
        'alt': 'Brown Rocks During Golden Hour',
      };
    });

    test('Empty', () {
      expect(emptyPhoto.id, 0);
      expect(emptyPhoto.width, 0);
      expect(emptyPhoto.height, 0);
      expect(emptyPhoto.url, '');
      expect(emptyPhoto.photographer, '');
      expect(emptyPhoto.photographerUrl, '');
      expect(emptyPhoto.photographerId, 0);
      expect(emptyPhoto.averageColor, '');
      expect(emptyPhoto.source, const PhotoSource.empty());
      expect(emptyPhoto.liked, false);
      expect(emptyPhoto.alt, '');
    });
    test('fromJson: Empty', () {
      Photo photo = Photo.fromJson(const Photo.empty().toJson());
      expect(photo.id, 0);
      expect(photo.width, 0);
      expect(photo.height, 0);
      expect(photo.url, '');
      expect(photo.photographer, '');
      expect(photo.photographerUrl, '');
      expect(photo.photographerId, 0);
      expect(photo.averageColor, '');
      expect(photo.source, const PhotoSource.empty());
      expect(photo.liked, false);
      expect(photo.alt, '');
    });
    test('fromJson: with Data', () {
      expect(photoFromJson, photoFromEntity);
    });
    test('FromEntity: Empty', () {
      expect(emptyPhoto.id, 0);
      expect(emptyPhoto.width, 0);
      expect(emptyPhoto.height, 0);
      expect(emptyPhoto.url, '');
      expect(emptyPhoto.photographer, '');
      expect(emptyPhoto.photographerUrl, '');
      expect(emptyPhoto.photographerId, 0);
      expect(emptyPhoto.source, const PhotoSource.empty());
      expect(emptyPhoto.averageColor, '');
      expect(emptyPhoto.liked, false);
      expect(emptyPhoto.alt, '');
      expect(emptyPhoto, const Photo.empty());
    });
    test('FromEntity: with Data', () {
      expect(photoFromEntity, photoFromJson);
    });
    test('ToJson: empty Data', () {
      expect(emptyPhoto.toJson(), <String, dynamic>{
        'id': 0,
        'width': 0,
        'height': 0,
        'url': '',
        'photographer': '',
        'photographer_url': '',
        'photographer_id': 0,
        'src': {
          'portrait': '',
          'small': '',
          'medium': '',
          'large': '',
          'original': '',
          'large2x': '',
          'tiny': '',
          'landscape': '',
        },
        'average_color': '',
        'liked': false,
        'alt': '',
      });
    });
    test('ToJson: with Data', () {
      expect(photoFromEntity.toJson(), jsonValue);
    });
  });
}
