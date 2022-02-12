import 'package:flutter/cupertino.dart';
import 'package:store_revision/feature/presentation/utils/options.dart';
import 'package:store_revision/generated/l10n.dart';

class UploadWidget extends StatefulWidget {
  final Function? onDownload;
  final Function? pickup;
  final Function? pickCamera;
  final Function? onDeleted;
  final Widget actionChild;

  const UploadWidget({
    Key? key,
    this.onDownload,
    this.pickup,
    this.pickCamera,
    this.onDeleted,
    required this.actionChild,
  }) : super(key: key);

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  List<Option> fileOption = [];
  dynamic _chosenFileValue;
  Function? _pickup;
  Function? _pickCamera;
  Function? _onDeleted;
  Function? _onDownload;
  late Widget actionChild;

  @override
  void initState() {
    _pickup = widget.pickup;
    _pickCamera = widget.pickCamera;
    _onDeleted = widget.onDeleted;
    _onDownload = widget.onDownload;
    actionChild = widget.actionChild;
    if (_pickCamera != null) {
      fileOption.add(Option.camera);
    }
    if (_pickup != null) {
      fileOption.add(Option.gallery);
    }
    if (_onDownload != null) {
      fileOption.insert(0, Option.download);
    }
    if (_onDeleted != null) {
      fileOption.add(Option.delete);
    }

    super.initState();
  }

  //  Функция для скачивания файла по url
  // void _launchUrl(String url, BuildContext context) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     await getErrorFlushbar(
  //       context,
  //       S.of(context).fileNotOpened,
  //     ).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        setState(() {
          _chosenFileValue = null;
        });
        await showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: fileOption.map((action) {
              return CupertinoActionSheetAction(
                child: Text(action.localize(context)),
                onPressed: () {
                  setState(() {
                    _chosenFileValue = action;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
            cancelButton: CupertinoActionSheetAction(
              child: Text(S.of(context).close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ).whenComplete(() => {
              if (_chosenFileValue == Option.download)
                {_onDownload!()}
              else if (_chosenFileValue == Option.camera)
                {_pickCamera!()}
              else if (_chosenFileValue == Option.gallery)
                {_pickup!()}
              else if (_chosenFileValue == Option.delete)
                {_onDeleted!()}
            });
      },
      child: actionChild,
    );
  }
}
