import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fwitter/models/emoji/emoji_model.dart';
import 'package:fwitter/models/user/user_model.dart';
import 'package:intl/intl.dart';

part 'fweet_model.freezed.dart';
part 'fweet_model.g.dart';

@freezed
class FweetModel with _$FweetModel {
  const FweetModel._();

  const factory FweetModel(
    int id,
    String text,
    UserModel creator,
    List<EmojiModel> emojis,
    DateTime createdAt,
  ) = _FweetModel;

  String? get formattedDate => DateFormat.yMMMd('RU').format(
        createdAt.toLocal(),
      );

  factory FweetModel.fromJson(Map<String, dynamic> json) =>
      _$FweetModelFromJson(json);

  // static FweetModel get mockFweet => FweetModel(178...);
}
