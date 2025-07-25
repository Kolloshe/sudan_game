import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends SpriteAnimationComponent with HasGameReference {
  static const double playerSpeed = 200.0;
  static const double playerSize = 32.0;

  SpriteAnimation? idleAnimation;
  SpriteAnimation? walkAnimation;
  SpriteAnimation? attackAnimation;

  Vector2? targetPosition;
  bool isMoving = false;
  bool isAttacking = false;

  @override
  Future<void> onLoad() async {
    size = Vector2.all(playerSize);
    position = Vector2(100, 100);

    // Load player sprites (you'll need to add actual sprite images)
    // For now, we'll create a simple colored rectangle
    await _loadAnimations();
  }

  Future<void> _loadAnimations() async {
    try {
      // Create simple animations for now
      // In a real game, you'd load actual sprite sheets
      final idleSprite = Sprite(game.images.fromCache('player_idle.png'));
      final walkSprite = Sprite(game.images.fromCache('player_walk.png'));
      final attackSprite = Sprite(game.images.fromCache('player_attack.png'));

      idleAnimation = SpriteAnimation.spriteList([idleSprite], stepTime: 0.1);

      walkAnimation = SpriteAnimation.spriteList([walkSprite], stepTime: 0.1);

      attackAnimation = SpriteAnimation.spriteList([attackSprite], stepTime: 0.05);

      animation = idleAnimation;
    } catch (e) {
      // If sprites fail to load, we'll use fallback rendering
      debugPrint('Failed to load player sprites: $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isAttacking) {
      if (attackAnimation != null) {
        animation = attackAnimation;
      }
      return;
    }

    if (targetPosition != null && isMoving) {
      final direction = targetPosition! - position;
      final distance = direction.length;

      if (distance > 5) {
        // Move towards target
        final movement = direction.normalized() * playerSpeed * dt;
        position += movement;
        if (walkAnimation != null) {
          animation = walkAnimation;
        }
      } else {
        // Reached target
        position = targetPosition!;
        targetPosition = null;
        isMoving = false;
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

  void moveTo(Vector2 position) {
    targetPosition = position;
    isMoving = true;
  }

  void attack() {
    if (!isAttacking) {
      isAttacking = true;
      if (attackAnimation != null) {
        animation = attackAnimation;
      }

      // Reset attack after animation completes
      Future.delayed(const Duration(milliseconds: 500), () {
        isAttacking = false;
      });
    }
  }

  @override
  void render(Canvas canvas) {
    // Fallback rendering if sprites aren't loaded
    if (animation == null) {
      final paint = Paint()..color = Colors.blue;
      canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
    } else {
      super.render(canvas);
    }
  }
}
