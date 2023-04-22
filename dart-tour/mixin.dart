// #class가 없는 constructor
// mixin class들을 하나의 클래스에 단 한번만 사용한다면 의미 없음
// 여러 클래스에 재사용 가능하다

// ! mixin의 조건: 생성자가 없는 클래스여야함.
class Strong {
  final double strengthLevel = 1400.99;
}

class QuickRunner {
  void runQuick() {
    print("runnnnnnnnn!");
  }
}

class Tall {
  final double height = 1.99;
}

enum Team { blue, red }

class Player with Strong, QuickRunner, Tall {
  final Team team;
  Player({
    required this.team,
  });
}

class Horse with Strong, QuickRunner {}

class Kid with Tall {}

void main() {
  var player = Player(
    team: Team.red,
  );
  player.height;
  player.runQuick();
}
