part of '../dataGrid.dart';

class PlutoColumnTypePhoto implements PlutoColumnType {
  @override
  final dynamic defaultValue;
  final String url;

  const PlutoColumnTypePhoto({
    this.defaultValue,
    this.url = '',
  });

  @override
  bool isValid(dynamic value) {
    return value is String;
  }

  @override
  dynamic makeCompareValue(dynamic v) {
    return v.toString();
  }

  @override
  int compare(a, b) {
    return 1;
  }
}

class PlutoColumnTypeInput extends PlutoColumnTypeText {
  const PlutoColumnTypeInput({
    super.defaultValue,
  });
}

class GridController extends GetxController {
  DataGridState widget;
  GridController({
    required this.widget,
  });
  @override
  void onInit() {
    super.onInit();
    // debugPrint('onInit');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  PlutoColumnType getType(ColumnDef x) {
    switch (x.type) {
      case ColumnType.text:
        return PlutoColumnType.text();
      case ColumnType.number:
        return PlutoColumnType.number();
      case ColumnType.currency:
        return PlutoColumnType.currency();
      case ColumnType.select:
        return PlutoColumnType.select(<LabelValue>[]);
      case ColumnType.date:
        return PlutoColumnType.date();
      case ColumnType.time:
        return PlutoColumnType.time();
      case ColumnType.photo:
        return const PlutoColumnTypePhoto();
      case ColumnType.input:
        return const PlutoColumnTypeInput();
    }
  }

  List<PlutoColumn> getColumns(List<ColumnDef> columns) {
    return columns.map((x) {
      if (x.type == ColumnType.photo) {
        return PlutoColumn(
          title: x.headerName,
          field: x.field,
          type: getType(x),
          enableAutoEditing: false,
          enableEditingMode: false,
          renderer: (rendererContext) {
            final String imageURL = rendererContext.cell.value as String;
            return ImageWidget(
              enabled_paint: x.enabled_imgEditor_paint,
              enabled_text: x.enabled_imgEditor_text,
              enabled_cropRotate: x.enabled_imgEditor_cropRotate,
              enabled_filter: x.enabled_imgEditor_filter,
              enabled_blur: x.enabled_imgEditor_blur,
              enabled_emoji: x.enabled_imgEditor_emoji,
              '$imageURL',
              enabled_Edit: x.enabled_imgEditor,
              onImageEditingComplete: (bts) async {
                if (widget.widget.onImageEditingComplete != null)
                  await widget.widget.onImageEditingComplete!(
                      bts, rendererContext);
                return true;
              },
            );
          },
        );
      }
      if (x.type == ColumnType.input) {
        return PlutoColumn(
          title: x.headerName,
          field: x.field,
          type: getType(x),
          enableAutoEditing: false,
          enableEditingMode: false,
          renderer: (rendererContext) {
            String str = rendererContext.cell.value as String;
            return TextCell(
              value: str,
              onChanged: (v) {
                final cell = rendererContext.cell;
                rendererContext.stateManager.changeCellValue(cell, v);
              },
            );
          },
        );
      }
      return PlutoColumn(
        title: x.headerName,
        field: x.field,
        type: getType(x),
      );
    }).toList();
  }

  setRowData(List<dynamic> arr, PlutoGridStateManager stateManager) {
    var rows = arr.map((x) {
      Map<String, PlutoCell> cells = {};
      x.forEach((key, value) {
        cells.addAll({
          key: PlutoCell(
            value: value,
          )
        });
      });
      return PlutoRow(
        cells: cells,
      );
    }).toList();
    stateManager.removeAllRows();
    stateManager.appendRows(rows);
  }
}
