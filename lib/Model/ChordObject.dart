class ChordObject {
  String trebleNote = "";
  String trebleKey = "Maj";
  List<String> trebleTension = new List<String>();
  String trebleInversion = "R";
  String trebleGrooves = "𝅝";

  String bassNote = "";
  String bassKey = "Maj";
  List<String> bassTension = new List<String>();
  String bassInversion = "R";
  String bassGrooves = "𝅝";

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
