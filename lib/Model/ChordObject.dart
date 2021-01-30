class ChordObject {
  String trebleNote = "";
  String trebleKey = "Maj";
  List<String> trebleTension = new List<String>();
  String trebleInversion = "R";
  String trebleArpeggios = "1";

  String bassNote = "";
  String bassKey = "Maj";
  List<String> bassTension = new List<String>();
  String bassInversion = "R";
  String bassArpeggios = "1";

  ChordObject(
      {tNote,
      tKey,
      tTension,
      tInversion,
      tArpeggios,
      bNote,
      bKey,
      bTension,
      bInversion,
      bArpeggios});
}
