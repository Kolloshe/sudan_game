import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Enemy extends SpriteAnimationComponent with HasGameReference {
  static const double enemySpeed = 100.0;
  static const double enemySize = 32.0;

  SpriteAnimation? idleAnimation;
  SpriteAnimation? walkAnimation;

  Vector2? patrolTarget;
  Vector2 startPosition = Vector2.zero();
  double patrolRadius = 100.0;
  bool isPatrolling = true;

  @override
  Future<void> onLoad() async {
    size = Vector2.all(enemySize);
    startPosition = position;

    await _loadAnimations();
    _setNewPatrolTarget();
  }

  Future<void> _loadAnimations() async {
    try {
      // Create simple animations for now
      final idleSprite = Sprite(game.images.fromCache('enemy_idle.png'));
      final walkSprite = Sprite(game.images.fromCache('enemy_walk.png'));

      idleAnimation = SpriteAnimation.spriteList([idleSprite], stepTime: 0.1);

      walkAnimation = SpriteAnimation.spriteList([walkSprite], stepTime: 0.1);

      animation = idleAnimation;
    } catch (e) {
      // If sprites fail to load, we'll use fallback rendering
      debugPrint('Failed to load enemy sprites: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPatrolling && patrolTarget != null) {
      final direction = patrolTarget! - position;
      final distance = direction.length;

      if (distance > 5) {
        // Move towards patrol target
        final movement = direction.normalized() * enemySpeed * dt;
        position += movement;
        if (walkAnimation != null) {
          animation = walkAnimation;
        }
      } else {
        // Reached patrol target, set new one
        _setNewPatrolTarget();
        if (idleAnimation != null) {
          animation = idleAnimation;
        }
      }
    } else {
      if (idleAnimation != null) {
        animation = idleAnimation;
      }
    }
  }

  void _setNewPatrolTarget() {
    final random = math.Random();
    final angle = random.nextDouble() * 2 * math.pi;
    final distance = random.nextDouble() * patrolRadius;

    patrolTarget = startPosition + Vector2(distance * math.cos(angle), distance * math.sin(angle));
  }

  void chasePlayer(Vector2 playerPosition) {
    isPatrolling = false;
    patrolTarget = playerPosition;
  }

  void returnToPatrol() {
    isPatrolling = true;
    _setNewPatrolTarget();
  }

  @override
  void render(Canvas canvas) {
    // Fallback rendering if sprites aren't loaded
    if (animation == null) {
      final paint = Paint()..color = Colors.red;
      canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
    } else {
      super.render(canvas);
    }
  }
}
