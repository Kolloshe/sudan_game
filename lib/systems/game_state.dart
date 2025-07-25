class GameState {
  int _score = 0;
  int _health = 100;
  int _level = 1;
  double _playTime = 0.0;

  // Getters
  int get score => _score;
  int get health => _health;
  int get level => _level;
  double get playTime => _playTime;

  // Events
  void addScore(int points) {
    _score += points;
    _checkLevelUp();
  }

  void takeDamage(int damage) {
    _health = (_health - damage).clamp(0, 100);
  }

  void heal(int amount) {
    _health = (_health + amount).clamp(0, 100);
  }

  void _checkLevelUp() {
    final newLevel = (_score ~/ 1000) + 1;
    if (newLevel > _level) {
      _level = newLevel;
      // You could add level up effects here
    }
  }

  void update(double dt) {
    _playTime += dt;
  }

  void reset() {
    _score = 0;
    _health = 100;
    _level = 1;
    _playTime = 0.0;
  }

  Map<String, dynamic> toJson() {
    return {'score': _score, 'health': _health, 'level': _level, 'playTime': _playTime};
  }

  void fromJson(Map<String, dynamic> json) {
    _score = json['score'] ?? 0;
    _health = json['health'] ?? 100;
    _level = json['level'] ?? 1;
    _playTime = json['playTime'] ?? 0.0;
  }
}
