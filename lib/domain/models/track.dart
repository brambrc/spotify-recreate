import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'artist.dart';
import 'album.dart';

part 'track.g.dart';

@JsonSerializable()
class Track extends Equatable {
  final String id;
  final String name;
  final List<Artist> artists;
  final Album? album;
  final int durationMs;
  final bool explicit;
  final String? previewUrl;
  final int popularity;
  final int? trackNumber;
  final bool isLocal;
  final bool isPlayable;
  final String? externalUrl;
  final DateTime? addedAt;
  final bool isLiked;
  final String? lyricsUrl;

  const Track({
    required this.id,
    required this.name,
    required this.artists,
    this.album,
    required this.durationMs,
    required this.explicit,
    this.previewUrl,
    required this.popularity,
    this.trackNumber,
    required this.isLocal,
    required this.isPlayable,
    this.externalUrl,
    this.addedAt,
    required this.isLiked,
    this.lyricsUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  String get artistsString => artists.map((artist) => artist.name).join(', ');

  String get durationString {
    final minutes = durationMs ~/ 60000;
    final seconds = (durationMs % 60000) ~/ 1000;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String? get imageUrl => album?.imageUrl;

  Track copyWith({
    String? id,
    String? name,
    List<Artist>? artists,
    Album? album,
    int? durationMs,
    bool? explicit,
    String? previewUrl,
    int? popularity,
    int? trackNumber,
    bool? isLocal,
    bool? isPlayable,
    String? externalUrl,
    DateTime? addedAt,
    bool? isLiked,
    String? lyricsUrl,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
      artists: artists ?? this.artists,
      album: album ?? this.album,
      durationMs: durationMs ?? this.durationMs,
      explicit: explicit ?? this.explicit,
      previewUrl: previewUrl ?? this.previewUrl,
      popularity: popularity ?? this.popularity,
      trackNumber: trackNumber ?? this.trackNumber,
      isLocal: isLocal ?? this.isLocal,
      isPlayable: isPlayable ?? this.isPlayable,
      externalUrl: externalUrl ?? this.externalUrl,
      addedAt: addedAt ?? this.addedAt,
      isLiked: isLiked ?? this.isLiked,
      lyricsUrl: lyricsUrl ?? this.lyricsUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        artists,
        album,
        durationMs,
        explicit,
        previewUrl,
        popularity,
        trackNumber,
        isLocal,
        isPlayable,
        externalUrl,
        addedAt,
        isLiked,
        lyricsUrl,
      ];
}

