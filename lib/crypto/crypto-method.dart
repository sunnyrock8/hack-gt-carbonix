import 'package:agent_dart/agent_dart.dart';

abstract class CryptoMethod {
  /// use staic const as method name
  static const balanceOf = "balanceOf";
  static const getSymbol = "getSymbol";
  static const payOut = "payOut";
  static const transfer = "transfer";

  /// you can copy/paste from .dfx/local/canisters/counter/counter.did.js
  static final ServiceClass idl = IDL.Service(
    {
      CryptoMethod.balanceOf: IDL.Func([IDL.Text], [IDL.Nat], ['query']),
      CryptoMethod.getSymbol: IDL.Func([], [IDL.Text], ['query']),
      CryptoMethod.payOut: IDL.Func([IDL.Text], [IDL.Text], []),
      CryptoMethod.transfer:
          IDL.Func([IDL.Text, IDL.Text, IDL.Nat], [IDL.Text], []),
    },
  );
}
