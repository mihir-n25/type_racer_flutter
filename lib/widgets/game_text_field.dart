import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/utils/socket_client.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widgets/customButton.dart';

class GameTextField extends StatefulWidget {
  const GameTextField({super.key});

  @override
  State<GameTextField> createState() => _GameTextFieldState();
}

class _GameTextFieldState extends State<GameTextField> {
  final SocketMethods _socketMethods = SocketMethods();
  var playerMe =  null;
  late GameStateProvider? game;

@override
  void initState(){
    super.initState();
    game = Provider.of<GameStateProvider>(context , listen: false);
    findPLayerMe(game!);
  }

  findPLayerMe(GameStateProvider game){
    game.gameState['players'].forEach((player){
      if(player['socketId'] == SocketClient.instance.socket!.id){
        playerMe = player;
      }
    });
  }
  
  handleStart(GameStateProvider game){
    _socketMethods.startTimer(playerMe['_id'], game.gameState['id']);
  }

  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameStateProvider>(context);
    return CustomButton(
      text: "START",
      onTap: () => handleStart(gameData),
    );
  }
}