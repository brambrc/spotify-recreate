import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'artist.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends Equatable {
  final String id;
  final String name;
  final List<Artist> artists;
  final String albumType;
  final int totalTracks;
  final List<String> images;
  final DateTime releaseDate;
  final String releaseDatePrecision;
  final List<String> genres;
  final String? label;
  final int popularity;
  final String? externalUrl;
  final String? description;
  final bool isSaved;

  const Album({
    required this.id,
    required this.name,
    required this.artists,
    required this.albumType,
    required this.totalTracks,
    required this.images,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.genres,
    this.label,
    required this.popularity,
    this.externalUrl,
    this.description,
    required this.isSaved,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  String? get imageUrl => images.isNotEmpty ? images.first : null;

  String get artistsString => artists.map((artist) => artist.name).join(', ');

  String get releaseYear => releaseDate.year.toString();

  String get formattedReleaseDate {
    switch (releaseDatePrecision) {
      case 'year':
        return releaseYear;
      case 'month':
        return '${releaseDate.month}/${releaseDate.year}';
      case 'day':
      default:
        return '${releaseDate.day}/${releaseDate.month}/${releaseDate.year}';
    }
  }

  String get albumTypeDisplay {
    switch (albumType.toLowerCase()) {
      case 'album':
        return 'Album';
      case 'single':
        return 'Single';
      case 'compilation':
        return 'Compilation';
      default:
        return albumType;
    }
  }

  Album copyWith({
    String? id,
    String? name,
    List<Artist>? artists,
    String? albumType,
    int? totalTracks,
    List<String>? images,
    DateTime? releaseDate,
    String? releaseDatePrecision,
    List<String>? genres,
    String? label,
    int? popularity,
    String? externalUrl,
    String? description,
    bool? isSaved,
  }) {
    return Album(
      id: id ?? this.id,
      name: name ?? this.name,
      artists: artists ?? this.artists,
      albumType: albumType ?? this.albumType,
      totalTracks: totalTracks ?? this.totalTracks,
      images: images ?? this.images,
      releaseDate: releaseDate ?? this.releaseDate,
      releaseDatePrecision: releaseDatePrecision ?? this.releaseDatePrecision,
      genres: genres ?? this.genres,
      label: label ?? this.label,
      popularity: popularity ?? this.popularity,
      externalUrl: externalUrl ?? this.externalUrl,
      description: description ?? this.description,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        artists,
        albumType,
        totalTracks,
        images,
        releaseDate,
        releaseDatePrecision,
        genres,
        label,
        popularity,
        externalUrl,
        description,
        isSaved,
      ];
}

