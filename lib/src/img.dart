import 'dart:async';

import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_image_editor/pro_image_editor.dart';


import 'utils/utils.dart';


class ImageWidget extends StatefulWidget {
  bool? enabled_Edit;
  bool? enabled_paint;
  bool? enabled_text;
  bool? enabled_cropRotate;
  bool? enabled_filter;
  bool? enabled_blur;
  bool? enabled_emoji;

  Future Function(Uint8List)? onImageEditingComplete;
  String url;

  ImageWidget(
    this.url, {
    super.key,
    this.enabled_Edit,
    this.enabled_paint,
    this.enabled_text,
    this.enabled_cropRotate,
    this.enabled_filter,
    this.enabled_blur,
    this.enabled_emoji,
    this.onImageEditingComplete,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  GlobalKey key = GlobalKey();
  String baseUrl = '/';
  Uint8List? file;
  @override
  void initState() {
    super.initState();
    setState(() {
      file = null;
    });
    readJson('assets/json/config.json').then((Map<String, dynamic> config) {
      setState(() {
        baseUrl = config['apiUrl'];
      });
    });
  }

  void openEditor() {
    getFileByUrl(widget.url).then((value) {
      var f = value as Uint8List;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ProImageEditor.memory(
            f,
            key: key,
            callbacks: ProImageEditorCallbacks(
              onImageEditingComplete: (Uint8List bytes) async {
                /*
                  处理编辑后的图像的代码。将其上传到服务器作为示例。
                  您可以选择使用await，以便加载对话框在代码准备好之前保持可见，或者不使用async，以便加载对话框立即关闭。
                  默认情况下，字节是' jpg '格式。
                */
                if (widget.onImageEditingComplete != null) {
                  await widget.onImageEditingComplete!(bytes);
                }
                setState(() {
                  file = bytes;
                });
                Navigator.pop(context);
              },
            ),
            configs: ProImageEditorConfigs(
              i18n: I18n(
                various: I18nVarious(),
                paintEditor: I18nPaintingEditor(),
                textEditor: I18nTextEditor(),
                cropRotateEditor: I18nCropRotateEditor(),
                filterEditor: I18nFilterEditor(filters: I18nFilters()),
                emojiEditor: I18nEmojiEditor(),
                stickerEditor: I18nStickerEditor(),
                importStateHistoryMsg: 'Initialize Editor',
                cancel: 'Cancel',
                undo: '撤销',
                redo: 'Redo',
                done: 'Done',
                remove: 'Remove',
                doneLoadingMsg: 'Changes are being applied',
              ),
              paintEditorConfigs:
                  PaintEditorConfigs(enabled: widget.enabled_paint ?? true),
              textEditorConfigs:
                  TextEditorConfigs(enabled: widget.enabled_text ?? true),
              cropRotateEditorConfigs: CropRotateEditorConfigs(
                  enabled: widget.enabled_cropRotate ?? true),
              filterEditorConfigs:
                  FilterEditorConfigs(enabled: widget.enabled_filter ?? true),
              blurEditorConfigs:
                  BlurEditorConfigs(enabled: widget.enabled_blur ?? true),
              emojiEditorConfigs:
                  EmojiEditorConfigs(enabled: widget.enabled_emoji ?? true),
            ),
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BRow(children: [
      BCol(
          classNames: 'col-24',
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('App发送信息到Flutter'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Flutter发送信息到App'),
              ),
            ],
          )),
      BCol(
        classNames: 'col-24',
        child: Column(
          children: [
            file != null
                ? Image.memory(file!)
                : Image.network(
                    urlRedress('$baseUrl${widget.url}'),
                    fit: BoxFit.contain,
                    frameBuilder: (_, image, loadingBuilder, __) {
                      if (loadingBuilder == null) {
                        return const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return image;
                    },
                    loadingBuilder: (BuildContext context, Widget image,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return image;
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/img/noimg.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
            widget.enabled_Edit == true
                ? Positioned(
                    top: 5,
                    right: 10,
                    child: InkWell(
                      onTap: () => openEditor(),
                      child: const Icon(Icons.edit_outlined),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ]);
  }
}
/* 
“主题”指定图像编辑器的主题。
/// - heroTag是Image Editor小部件的唯一标签。默认为“Pro-Image-Editor-Hero”。
/// - ' i18n '用于国际化设置。默认情况下，它使用一个空的' I18n '实例。
/// - ' helperLines '在图像编辑器中配置辅助行。默认情况下，它使用一个空的“helplines”实例。
/// - ' layerInteraction '指定图层交互行为的选项。
/// - ' customWidgets '指定图像编辑器中使用的自定义小部件。默认情况下，它使用一个空的“CustomWidgets”实例。
/// - ' imageEditorTheme '设置图像编辑器的主题默认情况下，它使用一个空的' ImageEditorTheme '实例。
/// - ' icons '指定在图像编辑器中使用的图标。默认情况下，它使用一个空的' ImageEditorIcons '实例。
/// - ' mainEditorConfigs '配置主编辑器。默认情况下，它使用一个空的' MainEditorConfigs '实例。
/// - ' paintEditorConfigs '配置绘画编辑器。默认情况下，它使用一个空的“PaintEditorConfigs”实例。
/// - ' textEditorConfigs '配置文本编辑器默认情况下，它使用一个空的' TextEditorConfigs '实例。
/// - ' cropRotateEditorConfigs '配置裁剪和旋转编辑器。默认情况下，它使用一个空的‘CropRotateEditorConfigs’实例。
/// - ' filterEditorConfigs '配置过滤器编辑器默认情况下，它使用一个空的' FilterEditorConfigs '实例。
/// - ' blurEditorConfigs '配置模糊编辑器。默认情况下，它使用一个空的“BlurEditorConfigs”实例。
/// - emojiEditorConfigs配置表情符号编辑器默认情况下，它使用一个空的' EmojiEditorConfigs '实例。
/// - ' stickerEditorConfigs '配置贴纸编辑器。默认情况下，它使用一个空的' StickerEditorConfigs '实例。
/// - ' designMode '指定图像编辑器的设计模式。默认情况下，它是“imageeditordesignmode .material”。
/// - ' stateHistoryConfigs '保存与状态历史管理相关的配置。默认情况下，它使用一个空的' StateHistoryConfigs '实例。
/// - ' imageGenerationConfigs '保存与图像生成相关的配置。默认情况下，它使用一个空的“ImageGeneratioConfigs”实例。
/// - ' editorBoxConstraintsBuilder '配置全局[BoxConstraints]，当在模态底部表单中打开编辑器时使用。
 */