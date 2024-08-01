part of 'utils.dart';

/// 读取JSON文件
///
/// [url] - 要读取JSON文件地址 （本地json文件）
Future<Map<String, dynamic>> readJson(String url) async {
  String jsonString = await rootBundle.loadString(url);
  return json.decode(jsonString);
}

/// 获取指定 [url] , [Uint8List] 格式的文件
///
/// [url] - 要获取的文地址, 做为参数返回给后端。 (后端文件地址(后端返回))
Future<dynamic> getFileByUrl(String url) async {
  Map<String, dynamic> config = await readJson('assets/json/config.json');
  return BHttp.getInstance(baseUrl: config['apiUrl'])
      .then((instans) => instans.stream("/file/getFileByUrl", {'url': url}));
}
