class FeedbackModel {
  String feedback;
  String email;

  FeedbackModel({
    required this.feedback,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'feedback': feedback,
      'email': email,
    };
  }
}
