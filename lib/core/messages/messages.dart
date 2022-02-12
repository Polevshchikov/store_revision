import 'package:flutter/widgets.dart';

abstract class LocalizedMessage {
  String getLocalizedMessage(BuildContext context);
}

class EmptyMessage implements LocalizedMessage {
  const EmptyMessage();

  @override
  String getLocalizedMessage(BuildContext context) => '';
}

class RecoveryRequestSentSuccessfully implements LocalizedMessage {
  const RecoveryRequestSentSuccessfully();

  @override
  String getLocalizedMessage(BuildContext context) =>
      'recovery Request Sent Successfully';
}
