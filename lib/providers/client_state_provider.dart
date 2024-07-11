import 'package:flutter/material.dart';
import 'package:type_racer/models/client_state.dart';

class ClientStateProvider extends ChangeNotifier{
  ClientState _clientState = ClientState(
    timer: {
    'countdown' : '',
    'msg' : '',
  },
  );

  Map<String,dynamic> get clientState => _clientState.toJson();

  setClientState(timer){
    _clientState = ClientState(timer : timer);
    notifyListeners();
  }
}