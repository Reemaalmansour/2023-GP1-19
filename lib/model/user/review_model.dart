import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';

@freezed
@immutable
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required final String? authorName,
    required final String? authorUrl,
    required final String? language,
    required final String? profilePhotoUrl,
    required final int? rating,
    required final String? relativeTimeDescription,
    required final String? text,
    required final int? time,
  }) = _ReviewModel;
}

List<ReviewModel> dummyReviews = [
  const ReviewModel(
    authorName: "John Doe",
    authorUrl: "https://example.com/johndoe",
    language: "English",
    profilePhotoUrl: "https://example.com/profile/johndoe.jpg",
    rating: 4,
    relativeTimeDescription: "2 days ago",
    text: "Great experience overall. Highly recommended!",
    time: 1647696000, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "Alice Smith",
    authorUrl: "https://example.com/alicesmith",
    language: "English",
    profilePhotoUrl: "https://example.com/profile/alicesmith.jpg",
    rating: 5,
    relativeTimeDescription: "3 weeks ago",
    text: "Amazing service! Will definitely visit again.",
    time: 1645756800, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "Mohammed Ahmed",
    authorUrl: "https://example.com/mohammedahmed",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/mohammedahmed.jpg",
    rating: 3,
    relativeTimeDescription: "1 month ago",
    text: "مكان جميل وخدمة ممتازة. سأعود مرة أخرى.",
    time: 1643534400, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "Emma Brown",
    authorUrl: "https://example.com/emmabrown",
    language: "English",
    profilePhotoUrl: "https://example.com/profile/emmabrown.jpg",
    rating: 4,
    relativeTimeDescription: "2 months ago",
    text: "Had a pleasant experience. Staff was friendly.",
    time: 1641019200, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "Ahmed Ali",
    authorUrl: "https://example.com/ahmedali",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/ahmedali.jpg",
    rating: 5,
    relativeTimeDescription: "3 months ago",
    text: "تجربة رائعة! أوصي بها بشدة.",
    time: 1638926400, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "محمد عبدالله",
    authorUrl: "https://example.com/mohammedabdullah",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/mohammedabdullah.jpg",
    rating: 4,
    relativeTimeDescription: "3 weeks ago",
    text: "تجربة ممتازة! خدمة رائعة ومكان جميل.",
    time: 1645756800, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "فاطمة الشهري",
    authorUrl: "https://example.com/fatmaalshahri",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/fatmaalshahri.jpg",
    rating: 5,
    relativeTimeDescription: "1 month ago",
    text: "لا يوجد كلمات تصف روعة الخدمة والمكان. شكرًا!",
    time: 1643534400, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "عبدالرحمن الغامدي",
    authorUrl: "https://example.com/abdulrahmanalgamdi",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/abdulrahmanalgamdi.jpg",
    rating: 3,
    relativeTimeDescription: "2 months ago",
    text: "خدمة جيدة ولكن يمكن تحسين الأمور قليلاً.",
    time: 1641019200, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "سارة السلمان",
    authorUrl: "https://example.com/sarahalsalman",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/sarahalsalman.jpg",
    rating: 4,
    relativeTimeDescription: "3 months ago",
    text: "تجربة رائعة ومكان مريح للغاية. أنصح به بشدة.",
    time: 1638926400, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "يوسف العتيبي",
    authorUrl: "https://example.com/yousefaltayebi",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/yousefaltayebi.jpg",
    rating: 5,
    relativeTimeDescription: "4 months ago",
    text: "تجربة رائعة حقًا! الخدمة ممتازة والمكان مذهل.",
    time: 1636344000, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "عبدالله الغامدي",
    authorUrl: "https://example.com/abdullahalgamdi",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/abdullahalgamdi.jpg",
    rating: 4,
    relativeTimeDescription: "أسبوع واحد مضى",
    text: "تجربة رائعة! خدمة ممتازة ومكان مريح.",
    time: 1647312000, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "فاطمة الشهراني",
    authorUrl: "https://example.com/fatmaalshahrani",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/fatmaalshahrani.jpg",
    rating: 5,
    relativeTimeDescription: "شهرين مضت",
    text: "مكان جميل جداً وخدمة ممتازة. أوصي به بشدة!",
    time: 1644576000, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "محمد العتيبي",
    authorUrl: "https://example.com/mohammedalotaibi",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/mohammedalotaibi.jpg",
    rating: 3,
    relativeTimeDescription: "شهر واحد مضى",
    text: "تجربة جيدة، لكن الخدمة يمكن تحسينها قليلاً.",
    time: 1646966400, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "ليلى المالكي",
    authorUrl: "https://example.com/laylaalmaliki",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/laylaalmaliki.jpg",
    rating: 4,
    relativeTimeDescription: "ثلاثة أشهر مضت",
    text: "تجربة ممتازة وأنصح الجميع بزيارته.",
    time: 1645564800, // Example UNIX timestamp
  ),
  const ReviewModel(
    authorName: "أحمد الشمري",
    authorUrl: "https://example.com/ahmedalshammari",
    language: "Arabic",
    profilePhotoUrl: "https://example.com/profile/ahmedalshammari.jpg",
    rating: 5,
    relativeTimeDescription: "ستة أشهر مضت",
    text: "مكان رائع لقضاء الوقت مع الأصدقاء. خدمة ممتازة!",
    time: 1642934400, // Example UNIX timestamp
  ),
];
