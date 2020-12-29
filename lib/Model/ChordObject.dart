class ChordObject {
  String trebleNote;
  String trebleKey;
  String trebleTension;
  String trebleInversion;
  String trebleArpeggios;

  String bassNote;
  String bassKey;
  String bassTension;
  String bassInversion;
  String bassArpeggios;

  ChordObject(tNote, tKey, tTension, tInversion, tArpeggios, bNote, bKey,
      bTension, bInversion, bArpeggios) {
    this.trebleNote = tNote;
    this.trebleKey = tKey;
    this.trebleTension = tTension;
    this.trebleInversion = tInversion;
    this.trebleArpeggios = tArpeggios;
    this.bassNote = bNote;
    this.bassKey = bKey;
    this.bassTension = bTension;
    this.bassInversion = bInversion;
    this.bassArpeggios = bArpeggios;
  }
}
