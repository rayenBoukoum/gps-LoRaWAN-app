import 'dart:ui';

enum LanguageType{
  ENGLISH,
  FRENSH,
}

const String ENGLISH = "en";
const String FRENSH = "fr";

const String ASSET_PATH_LOCALIZATION = "assets/translations";


const Locale ENGLISH_LOCAL = Locale("en","US");
const Locale FRENSH_LOCAL = Locale("fr","TN");


extension LanguageTypeExtension on LanguageType {

  String getValue() {
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.FRENSH:
        return FRENSH;
    }
  }

}