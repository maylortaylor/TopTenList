import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:toptenlist/data/database.dart';
import 'package:toptenlist/models/List.dart';
import 'package:http/http.dart' as http;

/// A class similar to http.Response but instead of a String describing the body
/// it already contains the parsed Dart-Object
class ParsedResponse<T> {
  ParsedResponse(this.statusCode, this.body);
  final int statusCode;
  final T body;

  bool isOk() {
    return statusCode >= 200 && statusCode < 300;
  }
}

final int NO_INTERNET = 404;

class Repository {
  static final Repository _repo = new Repository._internal();

  AppListsDatabase database;

  static Repository get() {
    return _repo;
  }

  Repository._internal() {
    database = AppListsDatabase.get();
  }

  Future init() async {
    return await database.init();
  }

  /// Fetches the books from the Google Books Api with the query parameter being input.
  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
  Future<ParsedResponse<List<AppListItem>>> getAppLists(String input) async {
    //http request, catching error like no internet connection.
    //If no internet is available for example response is
    //TODO restricted language to english, feel free to remove that
    http.Response response = await http
        .get(
            "https://www.googleapis.com/books/v1/volumes?q=$input&langRestrict=en")
        .catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, []);
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, []);
    }
    // Decode and go to the items part where the necessary book information is
    List<dynamic> list = jsonDecode(response.body)['items'];

    Map<String, AppListItem> networkAppLists = {};

    for (dynamic jsonList in list) {
      AppListItem list = parseNetworkBook(jsonList);
      networkAppLists[list.id] = list;
    }

    //Adds information (if available) from database
    List<AppListItem> databaseAppList =
        await database.getAppLists([]..addAll(networkAppLists.keys));
    for (AppListItem list in databaseAppList) {
      networkAppLists[list.id] = list;
    }

    return new ParsedResponse(
        response.statusCode, []..addAll(networkAppLists.values));
  }

  Future<ParsedResponse<AppListItem>> getAppList(String id) async {
    http.Response response = await http
        .get("https://www.googleapis.com/books/v1/volumes/$id")
        .catchError((resp) {});
    if (response == null) {
      return new ParsedResponse(NO_INTERNET, null);
    }

    //If there was an error return null
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, null);
    }

    dynamic jsonList = jsonDecode(response.body);

    AppListItem list = parseNetworkBook(jsonList);

    //Adds information (if available) from database
    List<AppListItem> databaseAppList =
        await database.getAppLists([]..add(list.id));
    for (AppListItem databaseBook in databaseAppList) {
      if (databaseBook != null) {
        list = databaseBook;
      }
    }

    return new ParsedResponse(response.statusCode, list);
  }

  //TODO optimize and add status code (Parsed Response)
  Future<List<AppListItem>> getBooksById(List<String> ids) async {
    List<AppListItem> lists = [];

    //  int statusCode = 200;
    for (String id in ids) {
      ParsedResponse<AppListItem> list = await getAppList(id);

      // One of the books went wrong, save status code and continue
      //   if(book.statusCode < 200 || book.statusCode >= 300) {
      //     statusCode = book.statusCode;
      //    }

      if (list.body != null) {
        lists.add(list.body);
      }
    }

    return lists;
    //  return new ParsedResponse(statusCode, books);
  }

  Future<List<AppListItem>> getBooksByIdFirstFromDatabaseAndCache(
      List<String> ids) async {
    List<AppListItem> lists = [];
    List<String> idsToFetch = ids;

    List<AppListItem> databaseAppLists =
        await database.getAppLists([]..addAll(ids));

    for (AppListItem databaseAppList in databaseAppLists) {
      lists.add(databaseAppList);
      idsToFetch.remove(databaseAppList.id);
    }

    for (String id in idsToFetch) {
      http.Response response = await http
          .get("https://www.googleapis.com/books/v1/volumes/$id")
          .catchError((resp) {});
      /*  if(response == null) {
        return new ParsedResponse(NO_INTERNET, null);
      }
      //If there was an error return null
      if(response.statusCode < 200 || response.statusCode >= 300) {
        return new ParsedResponse(response.statusCode, null);
      }*/

      dynamic jsonList = jsonDecode(response.body);

      AppListItem list = parseNetworkBook(jsonList);
      updateBook(list);
      lists.add(list);
    }

    return lists;
  }

  AppListItem parseNetworkBook(jsonList) {
    Map volumeInfo = jsonList["volumeInfo"];
    String author = "No author";
    if (volumeInfo.containsKey("authors")) {
      author = volumeInfo["authors"][0];
    }
    String description = "No description";
    if (volumeInfo.containsKey("description")) {
      description = volumeInfo["description"];
    }

    return new AppListItem(
      title: jsonList["volumeInfo"]["title"],
      url: jsonList["volumeInfo"]["imageLinks"] != null
          ? jsonList["volumeInfo"]["imageLinks"]["smallThumbnail"]
          : "",
      id: jsonList["id"],
      creator: author,
      description: description,
    );
  }

  Future updateBook(AppListItem book) async {
    await database.updateAppList(book);
  }

  Future close() async {
    return database.close();
  }

  Future<List<AppListItem>> getFavoriteBooks() {
    return database.getFavoriteAppLists();
  }
}
