// ignore_for_file: non_constant_identifier_names

part of '../render.dart';

// /// 某个操作完成后，接下来 要进行的操作 的  映射关系（例如，按钮点击后，要做些什么。某个接口请求后，要做些什么）
// class ApiMap {
//   final List<ApiResultMap>? New;
//   final List<ApiResultMap>? init;
//   final List<ApiResultMap>? initMap;
//   final List<ApiResultMap>? fastSearch;
//   final List<ApiResultMap>? add;
//   final List<ApiResultMap>? edit;
//   final List<ApiResultMap>? delelte;
//   final List<ApiResultMap>? getRow;
//   final List<ApiResultMap>? getList;
//   final List<ApiResultMap>? export;
//   final List<ApiResultMap>? search;
//   final List<ApiResultMap>? delelteByList;
//   final List<ApiResultMap>? addDocument;
//   final List<ApiResultMap>? editDocument;
//   final List<ApiResultMap>? deleteDocument;
//   final List<ApiResultMap>? addDocumentByList;
//   final List<ApiResultMap>? editDocumentByList;
//   final List<ApiResultMap>? deleteDocumentByList;
//   final List<ApiResultMap>? insertDocument;
//   final List<ApiResultMap>? getDocumentList;
//   final List<ApiResultMap>? upload;
//   final List<ApiResultMap>? cellClicked;
//   final List<ApiResultMap>? capture;
//   final List<ApiResultMap>? btnClick;

//   /// 某个操作完成后，接下来 要进行的操作 的  映射关系（例如，按钮点击后，要做些什么。某个接口请求后，要做些什么）
//   ApiMap({
//     this.New,
//     this.init,
//     this.initMap,
//     this.fastSearch,
//     this.add,
//     this.edit,
//     this.delelte,
//     this.getRow,
//     this.getList,
//     this.export,
//     this.search,
//     this.delelteByList,
//     this.addDocument,
//     this.editDocument,
//     this.deleteDocument,
//     this.addDocumentByList,
//     this.editDocumentByList,
//     this.deleteDocumentByList,
//     this.insertDocument,
//     this.getDocumentList,
//     this.upload,
//     this.cellClicked,
//     this.capture,
//     this.btnClick,
//   });
// }

/// 某个操作完成后，接下来 要进行的操作 的  映射关系（例如，按钮点击后，要做些什么。某个接口请求后，要做些什么）
enum ApiMap {
  New,
  init,
  initMap,
  fastSearch,
  add,
  edit,
  delelte,
  getRow,
  getList,
  export,
  search,
  delelteByList,
  addDocument,
  editDocument,
  deleteDocument,
  addDocumentByList,
  editDocumentByList,
  deleteDocumentByList,
  insertDocument,
  getDocumentList,
  upload,
  cellClicked,
  capture,
  btnClick,
}
