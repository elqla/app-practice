class Human {
  final String name;
  Human({required this.name});
  void sayHello() {
    print("hi my name is $name");
  }
}

enum Team { blue, red }

class Player extends Human {
  final Team team;
  Player({
    required this.team,
    required String name,
  }) : super(name: name); // 확장한 부모클래스와 상호작용

  @override
  // Human에서 온 sayHello를 직접 만든 메소드로 대체
  void sayHello() {
    super.sayHello(); // 상위의 sayHello 호출하기
    print(" and i play for $team");
  }
}

void main() {
  var player = Player(
    team: Team.red,
    name: 'nico',
  );
  player.sayHello();
}
