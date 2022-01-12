class NoteObj {
  int? id;
  String? title;
  String? note;
  String? creatat;
  int? favourite;
  int? trash;

  NoteObj(
      {this.id,
      this.title,
      this.note,
      this.creatat,
      this.favourite,
      this.trash});

  NoteObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    creatat = json['creatat'];
    favourite = json['favourite'];
    trash = json['trash'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['creatat'] = creatat;
    data['favourite'] = favourite;
    data['trash'] = trash;

    return data;
  }

  @override
  String toString() {
    return "NoteObj(id: $id, title: $title, note: $note, creatat: $creatat,favourite: $favourite,trash: $trash)";
  }
}
