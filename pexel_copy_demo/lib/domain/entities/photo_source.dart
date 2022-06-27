import 'package:equatable/equatable.dart';

class PhotoSource extends Equatable {
  final String? original;
  final String? large2x;
  final String? large;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? landscape;
  final String? tiny;

  const PhotoSource({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  const PhotoSource.empty()
      : original = "",
        large2x = "",
        large = "",
        medium = "",
        small = "",
        portrait = "",
        landscape = "",
        tiny = "";

  PhotoSource.from(PhotoSource source)
      : original = source.original,
        large2x = source.large2x,
        large = source.large,
        medium = source.medium,
        small = source.small,
        portrait = source.portrait,
        landscape = source.landscape,
        tiny = source.tiny;

  PhotoSource.fromJson(Map<String, String> json)
      : original = json['original'],
        large2x = json['large2x'],
        large = json['large'],
        medium = json['medium'],
        small = json['small'],
        portrait = json['portrait'],
        landscape = json['landscape'],
        tiny = json['tiny'];

  Map<String, String> toJson() => {
        'original': original!,
        'large2x': large2x!,
        'large': large!,
        'medium': medium!,
        'small': small!,
        'portrait': portrait!,
        'landscape': landscape!,
        'tiny': tiny!,
      };

  @override
  List<Object?> get props => [original, large2x, large, medium, small, portrait, landscape, tiny];
}
