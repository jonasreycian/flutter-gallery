import 'package:flutter_test/flutter_test.dart';
import 'package:pexel_copy_demo/domain/entities/photo_source.dart';

void main() {
  group("Entity Testing: PhotoSource", () {
    late PhotoSource photoSource;
    late PhotoSource emptySource;
    late PhotoSource sourceFromJson;
    late Map<String, String> jsonValue;

    const String baseUrl = 'https://images.pexels.com/photos';
    setUp(() {
      emptySource = const PhotoSource.empty();

      photoSource = const PhotoSource(
        landscape: "$baseUrl/landscape",
        portrait: "$baseUrl/portrait",
        small: "$baseUrl/small",
        medium: "$baseUrl/medium",
        large: "$baseUrl/large",
        large2x: "$baseUrl/large2x",
        tiny: "$baseUrl/tiny",
        original: "$baseUrl/original",
      );

      sourceFromJson = PhotoSource.fromJson(const {
        'original': '$baseUrl/original',
        'large2x': '$baseUrl/large2x',
        'large': '$baseUrl/large',
        'medium': '$baseUrl/medium',
        'small': '$baseUrl/small',
        'portrait': '$baseUrl/portrait',
        'landscape': '$baseUrl/landscape',
        'tiny': '$baseUrl/tiny',
      });

      jsonValue = <String, String>{
        'original': '$baseUrl/original',
        'large2x': '$baseUrl/large2x',
        'large': '$baseUrl/large',
        'medium': '$baseUrl/medium',
        'small': '$baseUrl/small',
        'portrait': '$baseUrl/portrait',
        'landscape': '$baseUrl/landscape',
        'tiny': '$baseUrl/tiny',
      };
    });

    test("Empty", () {
      const source = PhotoSource.empty();
      expect(source.original, "");
      expect(source.large2x, "");
      expect(source.large, "");
      expect(source.medium, "");
      expect(source.small, "");
      expect(source.portrait, "");
      expect(source.landscape, "");
      expect(source.tiny, "");
    });
    test('PhotoSource.from with empty PhotoSource', () {
      final source = PhotoSource.from(emptySource);
      expect(source, emptySource);
    });

    test('PhotoSource.from with PhotoSource', () {
      final source = PhotoSource.from(photoSource);
      expect(source, photoSource);
    });
    test('PhotoSource.fromJson with data', () {
      final source = PhotoSource.fromJson(photoSource.toJson());
      expect(source.toJson(), sourceFromJson.toJson());
    });

    test('PhotoSource.toJson with data', () {
      expect(sourceFromJson.toJson(), jsonValue);
    });
  });
}
