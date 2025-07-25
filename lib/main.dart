import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/sudan_rise_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const SudanRiseApp());
}

class SudanRiseApp extends StatelessWidget {
  const SudanRiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudan Rise',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GameWidget<SudanRiseGame>(
            game: SudanRiseGame(),
            overlayBuilderMap: {
              'pause_menu': (context, game) => PauseMenuOverlay(game: game),
              'game_over': (context, game) => GameOverOverlay(game: game),
              'game_ui': (context, game) => GameUIOverlay(game: game),
            },
          ),
          // Add a simple UI overlay for controls
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GameControlsOverlay(key: const Key('game_controls')),
          ),
        ],
      ),
    );
  }
}

class GameControlsOverlay extends StatelessWidget {
  const GameControlsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // This will be connected to game controls later
            debugPrint('Move Left');
          },
          child: const Icon(Icons.arrow_back),
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint('Pause');
          },
          child: const Icon(Icons.pause),
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint('Move Right');
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}

class GameUIOverlay extends StatelessWidget {
  final SudanRiseGame game;

  const GameUIOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Score: ${game.gameState.score}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Health: ${game.gameState.health}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Level: ${game.gameState.level}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class PauseMenuOverlay extends StatelessWidget {
  final SudanRiseGame game;

  const PauseMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'PAUSED',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => game.resumeGame(), child: const Text('Resume')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => game.resetGame(), child: const Text('Restart')),
          ],
        ),
      ),
    );
  }
}

class GameOverOverlay extends StatelessWidget {
  final SudanRiseGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => game.resetGame(), child: const Text('Play Again')),
          ],
        ),
      ),
    );
  }
}
