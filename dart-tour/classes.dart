// Function 내에서 var 를 쓸땐 타입을 명시할 필요 없지만
// class에선 무조건 타입을 명시해줘야함.

// # dart class
// class Player {
//   final String name = 'nico'; // final을 쓰면 못바꿈
//   int xp = 1500;

//   void sayHello() {
//     // this를 안써줘도 됨. this를 써줘도 되지만, 메소드 내에서 같은 이름이 있는 변수가
//     // 있는게 아니면 권장 X
//     // var name = '121'; // $name
//     print('hi my name is $name'); // ${this.name}
//   }
// }

// void main() {
//   var player = Player(); // new를 부를 필요도 없음. 이렇게 하면 하나의 player instance가 생성됨
//   // player.name = 'lalala';
//   print(player.name);
//   player.sayHello();
// }

// # Constructors   -----  feat positional argument
// class Player {
//   final String name; // ! 값 나중에 받아옴 (late)
//   int xp;

//   Player(this.name, this.xp); // much better costructor

//   void sayHello() {
//     print('hi my name is $name');
//   }
// }

// void main() {
//   var player =
//       Player('nico', 1000); // new를 부를 필요도 없음. 이렇게 하면 하나의 player instance가 생성됨
//   player.sayHello();
//   var player2 = Player('nico2', 1500);
//   player2.sayHello();
// }

//

// # named constructor parameters
// class Player {
//   final String name;
//   int xp, age;
//   String team;

//   // named constructor parameters
//   Player({
//     required this.name,
//     required this.xp,
//     required this.team,
//     required this.age,
//   });

//   void sayHello() {
//     print('hi my name is $name');
//   }
// }

// void main() {
//   var player = Player(
//     name: 'nico',
//     xp: 1200,
//     team: 'blue',
//     age: 21,
//   );
//   player.sayHello();

//   var player2 = Player(
//     name: 'nico2',
//     xp: 1500,
//     team: 'red',
//     age: 10,
//   );
//   player2.sayHello();
// }

//

// # named constructor
// class Player {
//   final String name;
//   int xp, age;
//   String team;

//   // named constructor parameters
//   Player({
//     required this.name,
//     required this.xp,
//     required this.team,
//     required this.age,
//   });

//   Player.createBluePlayer({
//     required String name,
//     required int age, // 여기서 받은 age가 밑줄에 들어감.
//   })  : this.age = age,
//         this.name = name,
//         this.team = 'blue',
//         this.xp = 0;

//   Player.createRedPlayer(
//     String name,
//     int age,
//   )   : this.age = age,
//         this.name = name,
//         this.team = 'red',
//         this.xp = 2;

//   void sayHello() {
//     print('hi my name is $name');
//   }
// }

// void main() {
//   var player = Player.createBluePlayer(
//     name: 'nico',
//     age: 12,
//   );
//   var player2 = Player.createRedPlayer(
//     'nico',
//     12,
//   );
// }

//

// # Recap
class Player {
  final String name;
  int xp;
  String team;

  Player.fromJson(Map<String, dynamic> playerJson)
      : name = playerJson['name'],
        xp = playerJson['xp'],
        team = playerJson['team'];

  void sayHello() {
    print('hi my name is $name');
  }
}

void main() {
  var apiData = [
    {
      "name": "nico",
      "team": "red",
      "xp": 0,
    },
    {
      "name": "lynn",
      "team": "blue",
      "xp": 0,
    },
    {
      "name": "lalsk",
      "team": "red",
      "xp": 0,
    },
  ];

  apiData.forEach((playerJson) {
    var player = Player.fromJson(playerJson);
    player.sayHello();
  });
}
