import 'package:kotgltd/packages/dependencies.dart';

part 'wallet.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 8)
class Wallet {
  @HiveField(0)
  int balance;

  Wallet({required this.balance});

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
