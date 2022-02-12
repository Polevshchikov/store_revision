import 'package:flutter/widgets.dart';
import 'package:store_revision/generated/l10n.dart';

enum Option { camera, gallery, download, delete }

extension OptionExtension on Option {
  String localize(BuildContext context) {
    switch (this) {
      case Option.download:
        return S.of(context).download;
      case Option.camera:
        return S.of(context).camera;
      case Option.gallery:
        return S.of(context).gallery;
      case Option.delete:
        return S.of(context).delete;
      default:
        return '';
    }
  }
}
