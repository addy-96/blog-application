import 'package:intl/intl.dart';

String getFormattedDatedMMMyyyy(DateTime datetime) {
  return DateFormat('d MMM, yyyy').format(datetime);
}
