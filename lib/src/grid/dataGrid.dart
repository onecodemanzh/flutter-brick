
// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:get/get.dart';


import '../form/form.dart';
import '../img.dart';
import '../pagination.dart';
import 'controllers/textCell.dart';
part './controllers/gridController.dart';
part './types/gridProps.dart';
part './types/column.dart';

// ignore: must_be_immutable
class DataGrid extends StatefulWidget {
  DataGrid({
    super.key,
    required this.props,
    this.ref,
    this.onPageChange,
    this.onImageEditingComplete,
  });

  @override
  GlobalKey<DataGridState>? key;
  Future<bool> Function(int)? onPageChange;
  Future<dynamic> Function(Uint8List, PlutoColumnRendererContext)?
      onImageEditingComplete;

  String? ref;

  GridProps props;

  @override
  State<DataGrid> createState() => DataGridState();
}

class DataGridState extends State<DataGrid> {
  GlobalKey listKey = GlobalKey<PlutoGridState>();
  late final Pagination pagination;
  @override
  void initState() {
    super.initState();
    if (widget.props.pagination != null) {
      pagination = Pagination(
            key: GlobalKey(),
            total: widget.props.pagination.total,
            pageSize: widget.props.pagination.pageSize,
            classNames: widget.props.pagination.classNames,
            showTotal: widget.props.pagination.showTotal,
            disabled: widget.props.pagination.disabled,
            hideOnSinglePage: widget.props.pagination.hideOnSinglePage,
            pageSizeOptions: widget.props.pagination.pageSizeOptions,
            showQuickJumper: widget.props.pagination.showQuickJumper,
            showSizeChanger: widget.props.pagination.showSizeChanger,
            showFirstLast: widget.props.pagination.showFirstLast,
            simple: widget.props.pagination.simple,
            onPageChange: (int currentIndex, int total) {
              widget.onPageChange!(currentIndex);
            },
          );
    } else {
      pagination = Pagination(
            key: GlobalKey(),
          );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
    // controller.dispose();
  }

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
    PlutoColumnGroup(title: 'User information', fields: ['name', 'age']),
    PlutoColumnGroup(title: 'Status', children: [
      PlutoColumnGroup(title: 'A', fields: ['role'], expandedColumn: true),
      PlutoColumnGroup(title: 'Etc.', fields: ['joined', 'working_time']),
    ]),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;
  late final GridController controller =
      Get.put<GridController>(GridController(widget: this), permanent: false);
  @override
  Widget build(BuildContext context) {
    var columns = controller.getColumns(widget.props.columns);

    var box = SizedBox(
      height: widget.props.showPagination ? 30 : 0,
      child: pagination,
    );
    List<Widget> children = [
      SizedBox(
          height: widget.props.height,
          child: PlutoGrid(
            key: listKey,
            columns: columns,
            rows: [],
            columnGroups: widget.props.columnGroups,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              if (widget.props.onChanged != null) {
                widget.props.onLoaded!(event);
              }
              stateManager = event.stateManager;
              controller.setRowData([], stateManager);
              // stateManager.setAutoEditing(true);
              // stateManager.setShowColumnFilter(true);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              if (widget.props.onChanged != null) {
                widget.props.onChanged!(event);
              }
            },
            configuration: const PlutoGridConfiguration(),
          )),
      SizedBox(
        height: widget.props.showPagination ? 10 : 0,
      ),
      box,
    ];
    return Container(
      child: Column(children: children),
    );
  }
}
