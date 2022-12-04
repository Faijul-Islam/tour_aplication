import 'package:get/get.dart';

import 'bng.dart';
import 'eng.dart';

class Language extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    "en_US":eng,
    "bn_BD":ban,
  };

}