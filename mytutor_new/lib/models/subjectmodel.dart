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
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    subjectDesc = json['subject_description'];
    subjectPrice = json['subject_price'];
    tutorId = json['tutor_id'];
    subjectSession = json['subject_session'];
    subjectRating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['subject_desciption'] = subjectDesc;
    data['subject_price'] = subjectPrice;
    data['tutor_id'] = tutorId;
    data['subject_sessions'] = subjectSession;
    data['subject_rating'] = subjectRating;
    return data;
  }
}