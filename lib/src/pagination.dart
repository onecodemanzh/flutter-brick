
// ignore_for_file: overridden_fields

import 'dart:math';

import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'varriable/varriable.dart';

enum PaginationItemType {
  prev,
  next,
  first,
  last,
  sizeChanger,
  ellipsis,
  number
}

typedef PageChange = void Function(int currentPageIndex, int totalPages)?;

class PagerIndicatorItem extends StatefulWidget {
  final PaginationItemType type;
  final int? index;
  final bool isFocused;
  final List<int>? pageSizeOptions;
  int? pageSize;
  int? currentPageIndex;

  void Function(int pageSize)? onPageSizeChange;
  PagerIndicatorItem({
    super.key,
    required this.type,
    this.index,
    this.isFocused = false,
    this.pageSizeOptions = const [],
    this.pageSize,
    this.currentPageIndex,
    this.onPageSizeChange,
  });

  @override
  State<PagerIndicatorItem> createState() => _PagerIndicatorItemState();
}

class _PagerIndicatorItemState extends State<PagerIndicatorItem> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Widget item = const Text('');
    switch (widget.type) {
      case PaginationItemType.prev:
        item = Icon(
          Icons.arrow_back_ios_rounded,
          size: 14,
          color: widget.index == null
              ? paginationDisabledColor
              : paginationIconColor,
        );
        break;
      case PaginationItemType.next:
        item = Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: widget.index == null
              ? paginationDisabledColor
              : paginationIconColor,
        );
        break;
      case PaginationItemType.ellipsis:
        var isLeft = widget.currentPageIndex! > widget.index! ? true : false;
        item = Icon(
          isHover
              ? (isLeft
                  ? Icons.keyboard_double_arrow_left_rounded
                  : Icons.keyboard_double_arrow_right_rounded)
              : Icons.more_horiz_outlined,
          size: isHover ? 22 : 22,
          color: isHover ? paginationActiveColor : paginationEllipsisColor,
        );
        break;
      case PaginationItemType.number:
        item = Text(
          (widget.index! + 1).toString(),
          style: TextStyle(
            fontSize: paginationFontSize,
            color: widget.index == null
                ? paginationColor
                : widget.isFocused
                    ? paginationActiveColor
                    : paginationColor,
          ),
        );
        break;
      case PaginationItemType.first:
        item = Icon(
          Icons.first_page_outlined,
          size: 22,
          color: widget.index == null
              ? paginationDisabledColor
              : lighten(paginationIconColor, amount: 18),
        );
      case PaginationItemType.last:
        item = Icon(
          Icons.last_page_outlined,
          size: 22,
          color: widget.index == null
              ? paginationDisabledColor
              : lighten(paginationIconColor, amount: 18),
        );
      case PaginationItemType.sizeChanger:
        item = Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 1),
            //边框圆角设置
            borderRadius:
                BorderRadius.all(Radius.circular(paginationBorderRadius)),
          ),
          child: DropdownButton(
            value: widget.pageSize, // 当前选中的值
            underline: Container(color: Colors.transparent),
            style: TextStyle(fontSize: paginationFontSize),
            items: widget.pageSizeOptions!.map<DropdownMenuItem<int>>((value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value${'条/页'.tr}'),
              );
            }).toList(),
            onChanged: (newValue) {
              widget.onPageSizeChange!(newValue!);
            },
          ),
        );
    }
    return MouseRegion(
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      onHover: (event) {
        setState(() {
          isHover = true;
        });
      },
      cursor: widget.index == null
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(
            horizontal: widget.type == PaginationItemType.number
                ? (widget.index! >= 8 ? 6 : 9)
                : 0),
        decoration: BoxDecoration(
          border: widget.type == PaginationItemType.ellipsis
              ? null
              : Border.all(
                  color: widget.isFocused
                      ? paginationActiveBorderColor
                      : Colors.transparent),
          borderRadius:
              BorderRadius.all(Radius.circular(paginationBorderRadius)),
          // color: widget.isFocused ? const Color(0xff5078F0) : null,
        ),
        child: Center(
          child: item,
        ),
      ),
    );
  }
}

class Pagination extends StatefulWidget {
  /// 	数据总数
  final int total;
  @override
  final GlobalKey<PaginationState>? key;

  /// 每页条数
  int? pageSize = 10;
  bool? showFirstLast;
  bool? showTotal;

  /// 	禁用分页	boolean	-	1.5.0
  bool? disabled = false;

  /// 	只有一页时是否隐藏分页器	boolean	false
  bool? hideOnSinglePage;

  /// 	指定每页可以显示多少条
  List<int>? pageSizeOptions;

  /// 	是否可以快速跳转至某页	boolean	false
  bool? showQuickJumper;

  /// 	是否展示 pageSize 切换器，
  bool? showSizeChanger;

  /// 	当添加该属性时，显示为简单分页	boolean	-
  bool? simple;
  final PageChange onPageChange;
  String? classNames;

  Pagination({
    this.key,
    this.total = 0,
    this.pageSize,
    this.classNames = '',
    this.showTotal = true,
    this.disabled,
    this.hideOnSinglePage = false,
    this.pageSizeOptions = const [10, 20, 50, 100],
    this.showQuickJumper = false,
    this.showSizeChanger = true,
    this.showFirstLast = true,
    this.simple = false,
    this.onPageChange,
  });

  @override
  State<Pagination> createState() => PaginationState();
}

class PaginationState extends State<Pagination> {
  // 当两端同时出现省略(...)时中间展示条数
  int pagesBetweenEllipsesCount = 5;
  late int sideDiff;

  // 总页数
  int totalPages = 0;
  int? lastTotalPages;
  int? lastCurrentPageIndex;

  // 每页的数据数量
  late int pageSize;
  late int _total = 0;

  // 当前所在页
  int currentPageIndex = 0;
  String jumpPageIndex = '';

  @override
  void initState() {
    super.initState();
    pageSize = widget.pageSize!;
    initData();
  }

  initData() {
    setState(() {
      currentPageIndex = 0;
      _total = widget.total;
    });
    changeDate();
  }

  reset({
    required int total,
    required int current,
    required int size,
  }) {
    setState(() {
      _total = total;
      pageSize = size;
      totalPages = (total / pageSize).ceil();
      currentPageIndex = current - 1;
    });
  }

  changeDate() {
    totalPages = (_total / pageSize).ceil();
    sideDiff = (pagesBetweenEllipsesCount / 2).floor();
    if (currentPageIndex > totalPages) {
      currentPageIndex = 0;
    }
  }

  executepageChange() {
    if (widget.onPageChange != null) {
      if ((lastTotalPages == null || lastCurrentPageIndex == null) ||
          (lastTotalPages != totalPages ||
              lastCurrentPageIndex != currentPageIndex)) {
        lastTotalPages = totalPages;
        lastCurrentPageIndex = currentPageIndex;
        widget.onPageChange!(currentPageIndex, totalPages);
      }
    }
  }

  Widget pageItem(PagerIndicatorItem item) {
    return GestureDetector(
      onTapUp: (e) {
        if (item.index != null) {
          setState(() {
            currentPageIndex = item.index!;
          });
        }
        executepageChange();
      },
      child: item,
    );
  }

  List<Widget> generatePager() {
    List<Widget> pageItems = [];
    if (widget.showFirstLast == true && widget.simple != true) {
      pageItems.add(pageItem(PagerIndicatorItem(
        type: PaginationItemType.first,
        index: currentPageIndex != 0 ? 0 : null,
      )));
    }
    // prev添加上一页按钮（<）
    pageItems.add(pageItem(PagerIndicatorItem(
      type: PaginationItemType.prev,
      index: currentPageIndex > 0 ? currentPageIndex - 1 : null,
    )));

    // 添加数字number list
    List<int> indexesBetweenEllipses = [];
    bool isStart = false;
    bool isEnd = false;
    int index = max(1, currentPageIndex - sideDiff);
    // 居中模式
    for (; index <= min(currentPageIndex + sideDiff, totalPages - 2); index++) {
      if (index == 1) {
        isStart = true;
        // 添加第一页（首页）
        pageItems.add(pageItem(PagerIndicatorItem(
          type: PaginationItemType.number,
          index: 0,
          isFocused: currentPageIndex == 0,
        )));
      }
      if (index == totalPages - 2) {
        isEnd = true;
      }
      indexesBetweenEllipses.add(index);
    }
    if (min(currentPageIndex + sideDiff, totalPages - 2) == 0) {
      indexesBetweenEllipses.add(0);
    }
    // 补缺
    int lackDiff = pagesBetweenEllipsesCount - indexesBetweenEllipses.length;
    if (lackDiff > 0) {
      if (isStart) {
        for (int i = 0; i < lackDiff; i++) {
          if (index < totalPages - 1) {
            if (index == totalPages - 2) {
              isEnd = true;
            }
            indexesBetweenEllipses.add(index++);
          }
        }
      }
      if (isEnd) {
        var indexStart = indexesBetweenEllipses.first;
        for (int i = 0; i < lackDiff; i++) {
          if (indexStart > 1) {
            if (indexStart == 2) {
              isStart = true;
            }
            indexesBetweenEllipses.insert(0, --indexStart);
          }
        }
      }
    }
    for (var i = 0; i < indexesBetweenEllipses.length; i++) {
      int index = indexesBetweenEllipses[i];
      // 添加数字页码ui
      pageItems.add(pageItem(PagerIndicatorItem(
        type: PaginationItemType.number,
        index: index,
        isFocused: currentPageIndex == index,
      )));
    }
    // 尾页
    if (totalPages > 1 && currentPageIndex + 5 > totalPages) {
      pageItems.add(pageItem(PagerIndicatorItem(
        type: PaginationItemType.number,
        index: totalPages - 1,
        isFocused: currentPageIndex == totalPages - 1,
      )));
    }
    // next
    pageItems.add(pageItem(PagerIndicatorItem(
      type: PaginationItemType.next,
      index: currentPageIndex < totalPages - 1 ? currentPageIndex + 1 : null,
    )));
    if (widget.showFirstLast == true && widget.simple != true) {
      pageItems.add(pageItem(PagerIndicatorItem(
        type: PaginationItemType.last,
        index: currentPageIndex != totalPages - 1 ? totalPages - 1 : null,
      )));
    }

    // ...
    if (!isStart &&
        indexesBetweenEllipses.length >= pagesBetweenEllipsesCount) {
      // // 前
      if (widget.simple == true) {
        pageItems.insert(
            1,
            pageItem(PagerIndicatorItem(
              type: PaginationItemType.number,
              index: 0,
              isFocused: currentPageIndex == 1,
            )));
      }
      if (currentPageIndex > 4) {
        // 当前选中下标大于4时才展示前（...）
        pageItems.insert(
            ((widget.showFirstLast == false || widget.simple == true) ? 2 : 2),
            pageItem(PagerIndicatorItem(
              type: PaginationItemType.ellipsis,
              index: currentPageIndex - 5,
              currentPageIndex: currentPageIndex,
            )));
      }
    }
    if (!isEnd && indexesBetweenEllipses.length >= pagesBetweenEllipsesCount) {
      // 后
      if (currentPageIndex < totalPages - 5) {
        // 当前选中下标小于总页码减5时才展示后（...）
        pageItems.insert(
            pageItems.length -
                ((widget.showFirstLast == false || widget.simple == true)
                    ? 1
                    : 2),
            pageItem(PagerIndicatorItem(
              type: PaginationItemType.ellipsis,
              index: currentPageIndex + 5,
              currentPageIndex: currentPageIndex,
            )));
      }
      pageItems.insert(
          pageItems.length -
              ((widget.showFirstLast == false || widget.simple == true)
                  ? 1
                  : 2),
          pageItem(PagerIndicatorItem(
            type: PaginationItemType.number,
            index: totalPages - 1,
            isFocused: currentPageIndex == totalPages - 1,
          )));
    }
    if (widget.showSizeChanger == true && widget.simple != true) {
      pageItems.add(pageItem(PagerIndicatorItem(
        type: PaginationItemType.sizeChanger,
        pageSizeOptions: widget.pageSizeOptions,
        pageSize: widget.pageSize,
        onPageSizeChange: (n) {
          setState(() {
            widget.pageSize = n;
            pageSize = n;
            changeDate();
            executepageChange();
          });
        },
      )));
    }

    // executepageChange();
    return pageItems;
  }

  Widget text(String text) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
        child: Text(
          text.tr,
          style: TextStyle(
              fontSize: paginationFontSize - 1,
              fontWeight: FontWeight.w400,
              color: paginationColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQueryBuilder(builder: (context, constraints, screenData) {
      var styles = convertClassNamesToStyle(widget.classNames);
      var s = getStyle(screenData, constraints, styles);
      List<Widget> pageItems = generatePager();
      List<Widget> children = [];
      if (widget.showTotal == true && widget.simple != true) {
        children.add(
          text("Total\t$_total\titems"),
        );
      }

      children.addAll(pageItems.map((pageItem) {
        // int index = pageItems.indexOf(pageItem);
        return Container(
          // margin: const EdgeInsets.only(left: 10),
          child: pageItem,
        );
      }));

      if (widget.showQuickJumper == true && widget.simple != true) {
        children.add(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            text("跳至"),
            SizedBox(
              width: jumpPageIndex.length > 2 ? 40 : 30,
              child: TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: jumpPageIndex,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: currentPageIndex.toString().length),
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  var n = int.tryParse(value);
                  if (n is int) {
                    setState(() {
                      currentPageIndex =
                          n > totalPages ? totalPages - 1 : (n < 1 ? 1 : n - 1);
                    });
                    executepageChange();
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                ],
                cursorHeight: 14,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: paginationFontSize, height: formInputHeight),
                decoration: InputDecoration(
                  hintText: '${currentPageIndex + 1}',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: formBorder,
                  focusedBorder: formFocusedBorder,
                  isCollapsed: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(6, 9, 6, 9),
                ),
              ),
            ),
            text("页"),
          ],
        ));
      }
      return Container(
        alignment: s.sa ?? Alignment.centerLeft,
        padding: s.cp,
        margin: s.cm,
        color: s.bg,
        width: s.w,
        height: s.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: children.toList(),
        ),
      );
    });
  }
}

