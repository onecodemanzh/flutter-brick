import 'dart:convert';
import 'dart:typed_data';

import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:collection/collection.dart';
import 'package:get/get.dart' as _get;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:dio/dio.dart' as dio;
// import 'package:http/http.dart' as _http;

import '../button.dart';
import '../form/form.dart';
import '../grid/dataGrid.dart';
import '../pagination.dart';

part './types/http.dart';
part './types/paramsMap.dart';
part './types/pageConfig.dart';
part './types/props.dart';
part './types/apiMap.dart';
part './types/fn.dart';
part './types/refs.dart';
part 'fn/events_.dart';
part 'fn/events_btn.dart';
part './fn/before.dart';
part './fn/after.dart';
part './fn/crud_add.dart';
part './fn/crud_delete.dart';
part './fn/crud_edit.dart';
part './fn/crud_getList.dart';
part './fn/params.dart';
part './fn/fn_form.dart';

part 'controllers/renderController.dart';

class Render extends StatefulWidget {
  const Render({super.key, required this.props});

  final RenderProps props;

  @override
  State<Render> createState() => _RenderState();
}

class _RenderState extends State<Render> {
  final RenderController controller = _get.Get.put(RenderController());

  List<Widget> body = [];
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BoxConstraints? constraints;
    ScreenData? screenData;
    return MediaQueryBuilder(builder: (context, _constraints, _screenData) {
      if (constraints == null && screenData == null) {
        constraints = _constraints;
        screenData = _screenData;
        body = controller.render(
          props: widget.props,
          context: context,
          constraints: constraints!,
          screenData: screenData!,
          that: widget,
        );
      }

      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: body,
      );
    });
  }
}
