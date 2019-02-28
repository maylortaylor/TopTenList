import 'package:meta/meta.dart';

class AppListItem {
  static final db_id = "id";
  static final db_title = "title";
  static final db_url = "url";
  static final db_star = "star";
  static final db_creator = "creator";
  static final db_description = "description";

  String title, url, id, description, creator;
  bool starred;

  AppListItem({
    @required this.title,
    @required this.url,
    @required this.id,
    @required this.creator,
    @required this.description,
    this.starred = false,
  });

  AppListItem.fromMap(Map<String, dynamic> map)
      : this(
          title: map[db_title],
          url: map[db_url],
          id: map[db_id],
          starred: map[db_star] == 1,
          description: map[db_description],
          creator: map[db_creator],
        );

  Map<String, dynamic> toMap() {
    return {
      db_title: title,
      db_url: url,
      db_id: id,
      db_star: starred ? 1 : 0,
      db_description: description,
      db_creator: creator,
    };
  }
}
