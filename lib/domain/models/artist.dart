import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist extends Equatable {
  final String id;
  final String name;
  final List<String> genres;
  final int popularity;
  final int followers;
  final List<String> images;
  final String? externalUrl;
  final String? description;
  final bool isFollowing;

  const Artist({
    required this.id,
    required this.name,
    required this.genres,
    required this.popularity,
    required this.followers,
    required this.images,
    this.externalUrl,
    this.description,
    required this.isFollowing,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  String? get imageUrl => images.isNotEmpty ? images.first : null;

  String get followersString {
    if (followers < 1000) {
      return followers.toString();
    } else if (followers < 1000000) {
      return '${(followers / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(followers / 1000000).toStringAsFixed(1)}M';
    }
  }

  Artist copyWith({
    String? id,
    String? name,
    List<String>? genres,
    int? popularity,
    int? followers,
    List<String>? images,
    String? externalUrl,
    String? description,
    bool? isFollowing,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      genres: genres ?? this.genres,
      popularity: popularity ?? this.popularity,
      followers: followers ?? this.followers,
      images: images ?? this.images,
      externalUrl: externalUrl ?? this.externalUrl,
      description: description ?? this.description,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        genres,
        popularity,
        followers,
        images,
        externalUrl,
        description,
        isFollowing,
      ];
}

