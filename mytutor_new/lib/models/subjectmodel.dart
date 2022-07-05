class Subject {
  String? subjectId;
  String? subjectName;
  String? subjectDesc;
  String? subjectPrice;
  String? tutorId;
  String? subjectSession;
  String? subjectRating;

  Subject(
    {this.subjectId, 
    this.subjectName, 
    this.subjectDesc, 
    this.subjectPrice, 
    this.tutorId,
    this.subjectSession,
    this.subjectRating}
  );

  Subject.fromJson(Map<String, dynamic> json) {
    subjectId = json["subject_id"];
    subjectName = json["subject_name"];
  }
}