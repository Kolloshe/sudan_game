# Sudan Rise - Flame Game

A 2D game built with Flutter and Flame engine featuring tilemap support.

## Features

- **Tilemap Support**: Uses Flame Tiled for level design
- **Player Movement**: Tap to move the player character
- **Enemy AI**: Enemies patrol and can chase the player
- **Game State Management**: Score, health, and level tracking
- **Pause/Resume**: Full game pause functionality
- **Game Over**: Restart functionality when health reaches zero

## Setup

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Assets Structure**:
   ```
   assets/
   ├── images/
   │   ├── player_idle.png
   │   ├── player_walk.png
   │   ├── player_attack.png
   │   ├── enemy_idle.png
   │   └── enemy_walk.png
   ├── audio/
   └── tilemaps/
       ├── level_1.tmx
       ├── tileset.tsx
       └── tileset.png
   ```

3. **Run the Game**:
   ```bash
   flutter run
   ```

## Controls

- **Tap**: Move player to tapped location
- **Escape**: Pause/Resume game
- **Space**: Resume game when paused

## Game Structure

### Main Components

- `SudanRiseGame`: Main game class with tilemap loading
- `Player`: Player character with movement and attack animations
- `Enemy`: Enemy AI with patrol and chase behavior
- `GameState`: Manages score, health, and game progression

### Tilemap Integration

The game uses Tiled map editor format (.tmx) for level design:

- **Ground Layer**: Base terrain tiles
- **Obstacles Layer**: Collision objects and barriers
- **Tileset**: Defines tile properties and walkability

## Customization

### Adding New Levels

1. Create a new `.tmx` file in `assets/tilemaps/`
2. Update the game to load the new level
3. Add level-specific enemies and objectives

### Adding Sprites

1. Place sprite images in `assets/images/`
2. Update the component classes to load new sprites
3. Adjust animation timing and behavior

### Modifying Game Logic

- **Player Speed**: Modify `Player.speed` constant
- **Enemy Behavior**: Update `Enemy` class patrol and chase logic
- **Scoring**: Adjust `GameState` scoring system

## Dependencies

- `flame`: Core game engine
- `flame_tiled`: Tilemap support
- `flame_audio`: Audio playback
- `shared_preferences`: Save game data
- `provider`: State management

## Development Notes

- The game currently uses placeholder images (colored rectangles)
- Add actual sprite sheets for better visuals
- Implement collision detection between player and enemies
- Add sound effects and background music
- Create more complex level designs with Tiled

## Next Steps

1. Add actual sprite images and animations
2. Implement collision detection
3. Add sound effects and music
4. Create multiple levels
5. Add power-ups and collectibles
6. Implement save/load functionality
7. Add particle effects
8. Create a proper UI overlay for game stats
