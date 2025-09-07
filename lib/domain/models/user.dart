import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String displayName;
  final String? email;
  final List<String> images;
  final String country;
  final int followers;
  final int following;
  final String product; // free, premium
  final bool isCurrentUser;
  final DateTime? birthDate;
  final String? externalUrl;

  const User({
    required this.id,
    required this.displayName,
    this.email,
    required this.images,
    required this.country,
    required this.followers,
    required this.following,
    required this.product,
    required this.isCurrentUser,
    this.birthDate,
    this.externalUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String? get imageUrl => images.isNotEmpty ? images.first : null;

  bool get isPremium => product.toLowerCase() == 'premium';

  String get followersString {
    if (followers < 1000) {
      return followers.toString();
    } else if (followers < 1000000) {
      return '${(followers / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(followers / 1000000).toStringAsFixed(1)}M';
    }
  }

  String get followingString {
    if (following < 1000) {
      return following.toString();
    } else if (following < 1000000) {
      return '${(following / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(following / 1000000).toStringAsFixed(1)}M';
    }
  }

  String get productDisplayName {
    switch (product.toLowerCase()) {
      case 'premium':
        return 'Spotify Premium';
      case 'free':
        return 'Spotify Free';
      default:
        return 'Spotify $product';
    }
  }

  User copyWith({
    String? id,
    String? displayName,
    String? email,
    List<String>? images,
    String? country,
    int? followers,
    int? following,
    String? product,
    bool? isCurrentUser,
    DateTime? birthDate,
    String? externalUrl,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      images: images ?? this.images,
      country: country ?? this.country,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      product: product ?? this.product,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      birthDate: birthDate ?? this.birthDate,
      externalUrl: externalUrl ?? this.externalUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        displayName,
        email,
        images,
        country,
        followers,
        following,
        product,
        isCurrentUser,
        birthDate,
        externalUrl,
      ];
}

