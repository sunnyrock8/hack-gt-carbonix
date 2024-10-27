import 'package:agent_dart/agent_dart.dart';
import 'package:carbonix/crypto/crypto-method.dart';

class CryptoService {
  AgentFactory? _agentFactory;
  CanisterActor? get actor => _agentFactory?.actor;

  final String canisterId = 'bkyz2-fmaaa-aaaaa-qaaaq-cai';
  final String url = 'https://8c0e-170-140-104-116.ngrok-free.app';

  Future<void> setAgent(
      {String? newCanisterId,
      ServiceClass? newIdl,
      String? newUrl,
      Identity? newIdentity,
      bool? debug}) async {
    _agentFactory ??= await AgentFactory.createAgent(
      canisterId: newCanisterId ?? canisterId,
      url: newUrl ?? url,
      idl: newIdl ?? CryptoMethod.idl,
      identity: newIdentity,
      debug: debug ?? true,
    );
  }

  Future<dynamic> getSymbol() async {
    try {
      var res = await actor?.getFunc(CryptoMethod.getSymbol)?.call([]);
      print(res);

      return res;
    } catch (e) {}
  }

  Future<dynamic> balanceOf(String who) async {
    try {
      print('Getting balance');
      print(who);
      var res = await actor?.getFunc(CryptoMethod.balanceOf)?.call([who]);
      print('Got balance');

      return res;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> transfer(String to, String from, int amount) async {
    try {
      print('Transferring');
      var res =
          await actor?.getFunc(CryptoMethod.transfer)?.call([to, from, amount]);
      print(res);

      return res;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
