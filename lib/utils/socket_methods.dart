import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/client_state_provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/utils/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  bool _isPlaying = false;

  // create game
  createGame(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('create-game', {
        'nickname': nickname,
      });
    }
  }

  // join game
  joinGame(String gameId , String nickname) {
    if (nickname.isNotEmpty && gameId.isNotEmpty) {
      _socketClient.emit('join-game', {
        'nickname': nickname,
        'gameId' : gameId
      });
    }
  }

  sendUserInput(String value , String gameId){
    _socketClient.emit('userInput' , {
      'userInput' : value,
      'gameId' : gameId,
    });
  }

  updateGameListener(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      final gameStateProvider = Provider.of<GameStateProvider>(context , listen : false)
          .updateGameState(
              id: data['_id'],
              players: data['players'],
              isJoin: data['isJoin'],
              isOver: data['isOver'],
              words: data['words']);

             
              if(data['_id'].isNotEmpty && !_isPlaying){
                Navigator.pushNamed(context, '/game-screen');
                _isPlaying = true;
              }
    });
  }

  startTimer(playerId , gameId){
    _socketClient.emit('timer' , {
      'playerId' : playerId,
      'gameId' : gameId
    });
  }

  notCorrectGameListner(BuildContext context){
    _socketClient.on('notCorrectGame' , (data) => 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data))
    ),
    );
  }

  updateTimer(BuildContext context){
    final clientStateProvider = Provider.of<ClientStateProvider>(context , listen: false);
    _socketClient.on('timer' , (data){
    clientStateProvider.setClientState(data);
  });
  }

  updateGame(BuildContext context){
    _socketClient.on('updateGame', (data) {
      final gameStateProvider = Provider.of<GameStateProvider>(context , listen : false)
          .updateGameState(
              id: data['_id'],
              players: data['players'],
              isJoin: data['isJoin'],
              isOver: data['isOver'],
              words: data['words']);
  });
  }
}
