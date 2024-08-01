part of 'utils.dart';

/// 修正[url],去除重复的斜杠和反斜杠 （\\ 或  // ,修正 成 \ 或 /）
String urlRedress(String url) => url
    .replaceAll(RegExp('!(:\\\\)(\\\\)'), '/')
    .replaceAll(RegExp('(?<!:)//'), '/');

/// 获取 当前路由 子路由 做为 初始路由 （默认第一个子路由）
String initialRoute(BuildContext context, List<dynamic> routes) {
  ModalRoute<Object?>? currentRoute = ModalRoute.of(context);
  try {
    final name = currentRoute!.settings.name;
    final r = routes.where((x) => x.name == name);
    return r.first.children.first.name;
  } catch (err) {
    return '/';
  }
}
