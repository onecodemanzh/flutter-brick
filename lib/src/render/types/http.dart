// ignore_for_file: non_constant_identifier_names

part of '../render.dart';

typedef HttpFn = Future<dynamic> Function(
    [dynamic args, String? url, bool? loading])?;

abstract class Https {
  HttpFn? New;
  HttpFn? init;
  HttpFn? initMap;
  HttpFn? fastSearch;
  HttpFn? add;
  HttpFn? edit;
  HttpFn? delelte;
  HttpFn? getRow;
  HttpFn? getList;
  HttpFn? listImageEdit;
  HttpFn? export;
  HttpFn? search;
  HttpFn? delelteByList;
  HttpFn? addDocument;
  HttpFn? editDocument;
  HttpFn? deleteDocument;
  HttpFn? addDocumentByList;
  HttpFn? editDocumentByList;
  HttpFn? deleteDocumentByList;
  HttpFn? insertDocument;
  HttpFn? getDocumentList;
  HttpFn? upload;
  HttpFn? cellClicked;
  HttpFn? capture;
}

/// http 参数映射
class HttpParamsMap {
  final List<ParamsMap>? New;
  final List<ParamsMap>? init;
  final List<ParamsMap>? initMap;
  final List<ParamsMap>? fastSearch;
  final List<ParamsMap>? add;
  final List<ParamsMap>? edit;
  final List<ParamsMap>? delelte;
  final List<ParamsMap>? getRow;
  final List<ParamsMap>? getList;
  final List<ParamsMap>? listImageEdit;
  final List<ParamsMap>? export;
  final List<ParamsMap>? search;
  final List<ParamsMap>? delelteByList;
  final List<ParamsMap>? addDocument;
  final List<ParamsMap>? editDocument;
  final List<ParamsMap>? deleteDocument;
  final List<ParamsMap>? addDocumentByList;
  final List<ParamsMap>? editDocumentByList;
  final List<ParamsMap>? deleteDocumentByList;
  final List<ParamsMap>? insertDocument;
  final List<ParamsMap>? getDocumentList;
  final List<ParamsMap>? upload;
  final List<ParamsMap>? cellClicked;
  final List<ParamsMap>? capture;

  /// Http 参数 映射
  HttpParamsMap({
    this.New,
    this.init,
    this.initMap,
    this.fastSearch,
    this.add,
    this.edit,
    this.delelte,
    this.getRow,
    this.getList,
    this.listImageEdit,
    this.export,
    this.search,
    this.delelteByList,
    this.addDocument,
    this.editDocument,
    this.deleteDocument,
    this.addDocumentByList,
    this.editDocumentByList,
    this.deleteDocumentByList,
    this.insertDocument,
    this.getDocumentList,
    this.upload,
    this.cellClicked,
    this.capture,
  });
}

class HttpResultMap extends HttpParamsMap {
  HttpResultMap({
    super.New,
    super.init,
    super.initMap,
    super.fastSearch,
    super.add,
    super.edit,
    super.delelte,
    super.getRow,
    super.getList,
    super.listImageEdit,
    super.export,
    super.search,
    super.delelteByList,
    super.addDocument,
    super.editDocument,
    super.deleteDocument,
    super.addDocumentByList,
    super.editDocumentByList,
    super.deleteDocumentByList,
    super.insertDocument,
    super.getDocumentList,
    super.upload,
    super.cellClicked,
    super.capture,
  });
}
