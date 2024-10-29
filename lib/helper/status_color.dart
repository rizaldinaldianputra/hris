import 'package:hexcolor/hexcolor.dart';

statusColor(String status) {
  if (status == 'approved') {
    return HexColor('#E9FAEA');
  } else if (status == 'Rejected') {
    return HexColor('#FAE9E9');
  } else {
    return HexColor('#F7F6F6');
  }
}

statusColorText(String status) {
  if (status == 'approved') {
    return HexColor('#329B1B');
  } else if (status == 'Rejected') {
    return HexColor('#B21616');
  } else {
    return HexColor('#757575');
  }
}
