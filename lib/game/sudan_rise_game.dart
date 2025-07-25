import 'package:flame/game.dart';
import '../components/player.dart';
import '../components/enemy.dart';
import '../systems/game_state.dart';

class SudanRiseGame extends FlameGame {
  late Player player;
  late GameState gameState;

  bool isPaused = false;
  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    // Initialize game state
    gameState = GameState();

    // Add player
    player = Player();
    add(player);

    // Set camera to follow player
    camera.follow(player);

    // Add some enemies
    _spawnEnemies();

    // Add UI components
    _addUI();
  }

  void _spawnEnemies() {
    // Add enemies at specific positions
    final enemyPositions = [Vector2(200, 200), Vector2(400, 300), Vector2(600, 150)];

    for (final position in enemyPositions) {
      final enemy = Enemy();
      enemy.position = position;
      add(enemy);
    }
  }

  void _addUI() {
    // Add UI components here
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPaused || isGameOver) return;

    // Update game logic
    gameState.update(dt);

    // Check for game over conditions
    if (gameState.health <= 0) {
      gameOver();
    }
  }

  void togglePause() {
    if (isGameOver) return;

    isPaused = !isPaused;
    if (isPaused) {
      pauseEngine();
      overlays.add('pause_menu');
    } else {
      resumeEngine();
      overlays.remove('pause_menu');
    }
  }

  void resumeGame() {
    isPaused = false;
    resumeEngine();
    overlays.remove('pause_menu');
  }

  void gameOver() {
    isGameOver = true;
    pauseEngine();
    overlays.add('game_over');
  }

  void resetGame() {
    isPaused = false;
    isGameOver = false;
    gameState.reset();
    overlays.clear();
    resumeEngine();

    // Reset player position
    player.position = Vector2(100, 100);

    // Remove all enemies and respawn them
    removeAll(children.whereType<Enemy>());
    _spawnEnemies();
  }

  void addScore(int points) {
    gameState.addScore(points);
  }

  void takeDamage(int damage) {
    gameState.takeDamage(damage);
  }
}
