import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPrefrences {
  static SharedPreferences? _preferences;

  static const _keyTitle = 'title';
  static const _keyContent = 'content';
  static const _keyDes = 'des';
  static const _keySource = 'source';
  static const _keyNewsTime = 'newstime';
  static const _keyAuthor = 'author';
  static const _keyUrl = 'url';
  static const _keyImgUrl = 'imgurl';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTitle(List<String> title) async =>
      await _preferences?.setStringList(_keyTitle, title);
  static List<String> getTitle() =>
      _preferences?.getStringList(_keyTitle) ?? [];

  static Future setContent(List<String> content) async =>
      await _preferences?.setStringList(_keyContent, content);
  static List<String> getContent() =>
      _preferences?.getStringList(_keyContent) ?? [];

  static Future setDes(List<String> des) async =>
      await _preferences?.setStringList(_keyDes, des);
  static List<String> getDes() => _preferences?.getStringList(_keyDes) ?? [];

  static Future setSource(List<String> source) async =>
      await _preferences?.setStringList(_keySource, source);
  static List<String> getSource() =>
      _preferences?.getStringList(_keySource) ?? [];

  static Future setNewsTime(List<String> newstime) async =>
      await _preferences?.setStringList(_keyNewsTime, newstime);
  static List<String> getNewsTime() =>
      _preferences?.getStringList(_keyNewsTime) ?? [];

  static Future setAuthor(List<String> author) async =>
      await _preferences?.setStringList(_keyAuthor, author);
  static List<String> getAuthor() =>
      _preferences?.getStringList(_keyAuthor) ?? [];

  static Future setUrl(List<String> url) async =>
      await _preferences?.setStringList(_keyUrl, url);
  static List<String> getUrl() => _preferences?.getStringList(_keyUrl) ?? [];

  static Future setImgUrl(List<String> imgurl) async =>
      await _preferences?.setStringList(_keyImgUrl, imgurl);
  static List<String> getImgUrl() => _preferences?.getStringList(_keyUrl) ?? [];
}
