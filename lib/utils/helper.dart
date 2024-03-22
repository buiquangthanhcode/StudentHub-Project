import 'package:easy_localization/easy_localization.dart';

DateTime stringToDateTime(String? dateString) {
  try {
    return DateFormat('dd/MM/yyyy').parse(dateString ?? '1970-01-01');
  } catch (error) {
    return DateTime.parse('1970-01-01');
  }
}

// Hàm chuyển đổi DateTime thành chuỗi theo định dạng được chỉ định
String formatDateTime(DateTime dateTime, {String? format}) {
  try {
    return DateFormat(format ?? 'dd/MM/yyyy').format(dateTime);
  } catch (error) {
    return 'Invalid';
  }
}
