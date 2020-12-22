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

  // Getters and Setters
  // Treble
  String get getTrebleNote => trebleNote;
  set setTrebleNote(String trebleNote) => this.trebleNote = trebleNote;

  String get getTrebleKey => trebleKey;
  set setTrebleKey(String trebleKey) => this.trebleKey = trebleKey;

  String get getTrebleTension => trebleTension;
  set setTrebleTension(String trebleTension) =>
      this.trebleTension = trebleTension;

  String get getTrebleInversion => trebleInversion;
  set setTrebleInversion(String trebleInversion) =>
      this.trebleInversion = trebleInversion;

  String get getTrebleArpeggios => trebleArpeggios;
  set setTrebleArpeggios(String trebleArpeggios) =>
      this.trebleArpeggios = trebleArpeggios;

  // Bass
  String get getBassNote => bassNote;
  set setBassNote(String bassNote) => this.bassNote = bassNote;

  String get getBassKey => bassKey;
  set setBassKey(String bassKey) => this.bassKey = bassKey;

  String get getBassTension => bassTension;
  set setBassTension(String bassTension) => this.bassTension = bassTension;

  String get getBassInversion => bassInversion;
  set setBassInversion(String bassInversion) =>
      this.bassInversion = bassInversion;

  String get getBassArpeggios => bassArpeggios;
  set setBassArpeggios(String bassArpeggios) =>
      this.bassArpeggios = bassArpeggios;

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
