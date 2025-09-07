import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'track.dart';
import 'user.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Equatable {
  final String id;
  final String name;
  final String? description;
  final User owner;
  final List<String> images;
  final int totalTracks;
  final bool public;
  final bool collaborative;
  final List<Track>? tracks;
  final String? externalUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isFollowing;
  final bool isPinned;

  const Playlist({
    required this.id,
    required this.name,
    this.description,
    required this.owner,
    required this.images,
    required this.totalTracks,
    required this.public,
    required this.collaborative,
    this.tracks,
    this.externalUrl,
    this.createdAt,
    this.updatedAt,
    required this.isFollowing,
    required this.isPinned,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  String? get imageUrl => images.isNotEmpty ? images.first : null;

  String get tracksCountString {
    if (totalTracks == 1) {
      return '1 song';
    }
    return '$totalTracks songs';
  }

  Duration get totalDuration {
    if (tracks == null || tracks!.isEmpty) {
      return Duration.zero;
    }
    return Duration(
      milliseconds: tracks!.fold(0, (sum, track) => sum + track.durationMs),
    );
  }

  String get totalDurationString {
    final duration = totalDuration;
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get privacyString {
    if (collaborative) {
      return 'Collaborative playlist';
    } else if (public) {
      return 'Public playlist';
    } else {
      return 'Private playlist';
    }
  }

  bool get isOwnedByCurrentUser => owner.isCurrentUser;

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    User? owner,
    List<String>? images,
    int? totalTracks,
    bool? public,
    bool? collaborative,
    List<Track>? tracks,
    String? externalUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFollowing,
    bool? isPinned,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      images: images ?? this.images,
      totalTracks: totalTracks ?? this.totalTracks,
      public: public ?? this.public,
      collaborative: collaborative ?? this.collaborative,
      tracks: tracks ?? this.tracks,
      externalUrl: externalUrl ?? this.externalUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFollowing: isFollowing ?? this.isFollowing,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        owner,
        images,
        totalTracks,
        public,
        collaborative,
        tracks,
        externalUrl,
        createdAt,
        updatedAt,
        isFollowing,
        isPinned,
      ];
}

