import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  int id;
  String title;
  String releaseDate;
  String boxOffice;
  int duration;
  String coverUrl;
  String? trailerUrl;
  String directedBy;
  int phase;
  String saga;
  int chronology;
  int postCreditScenes;
  String imdbId;
  String updatedAt;

  Welcome({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.boxOffice,
    required this.duration,
    required this.coverUrl,
    this.trailerUrl,
    required this.directedBy,
    required this.phase,
    required this.saga,
    required this.chronology,
    required this.postCreditScenes,
    required this.imdbId,
    required this.updatedAt,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        title: json["title"],
        releaseDate: json["release_date"],
        boxOffice: json["box_office"],
        duration: json["duration"],
        coverUrl: json["cover_url"],
        trailerUrl: json["trailer_url"],
        directedBy: json["directed_by"],
        phase: json["phase"],
        saga: json["saga"],
        chronology: json["chronology"],
        postCreditScenes: json["post_credit_scenes"],
        imdbId: json["imdb_id"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "release_date": releaseDate,
        "box_office": boxOffice,
        "duration": duration,
        "cover_url": coverUrl,
        "trailer_url": trailerUrl,
        "directed_by": directedBy,
        "phase": phase,
        "saga": saga,
        "chronology": chronology,
        "post_credit_scenes": postCreditScenes,
        "imdb_id": imdbId,
        "updated_at": updatedAt,
      };
}
