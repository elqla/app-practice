// #abstract classes
abstract class Human {
  void walk();
}

// # cascade notation & Enums
enum Team { red, blue } // text형태로 쓸 필요 없음

enum XPLevel { beginner, medium, pro }

class Player extends Human {
  String name;
  XPLevel xp;
  Team team;

  Player({
    required this.name,
    required this.xp,
    required this.team,
  });

  void walk() {
    print('im walking ');
  }

  void sayHello() {
    print('hi my name is $name');
  }
}

class Coach extends Human {
  void walk() {
    print('the coach is walking');
  }
}

void main() {
  // cascade operator
  var nico = Player(name: 'nico', xp: XPLevel.medium, team: Team.red) //세미콜론지우고
    ..name = 'las'
    ..xp = XPLevel.beginner
    ..team = Team.blue;

  var lynn = Player(name: 'nico', xp: XPLevel.medium, team: Team.red);
  var potat = lynn
    ..name = 'las'
    ..xp = XPLevel.pro
    ..team = Team.blue
    ..sayHello();
}
