import 'package:flutter/cupertino.dart';
import 'package:store_revision/feature/presentation/utils/options.dart';
import 'package:store_revision/generated/l10n.dart';

class UploadWidget extends StatefulWidget {
  final Function? pickup;
  final Function? pickCamera;
  final Widget actionChild;

  const UploadWidget({
    Key? key,
    this.pickup,
    this.pickCamera,
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
  late Widget actionChild;

  @override
  void initState() {
    _pickup = widget.pickup;
    _pickCamera = widget.pickCamera;
    actionChild = widget.actionChild;
    if (_pickCamera != null) {
      fileOption.add(Option.camera);
    }
    if (_pickup != null) {
      fileOption.add(Option.gallery);
    }

    super.initState();
  }

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
              if (_chosenFileValue == Option.camera)
                {_pickCamera!()}
              else if (_chosenFileValue == Option.gallery)
                {_pickup!()}
            });
      },
      child: actionChild,
    );
  }
}
