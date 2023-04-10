// bool isEmpty(String string) => string.length == 0; // null doesnt have a length

void main() {
  // var || String 을 통해 변수 업데이트 가능
  String name = '니꼬'; // instead using var
  // 함수나, 메소드 내부의 지역변수 선언시 사용   // 컴파일러가 이미 string이라는걸 알기 때문
  var localName = 'nico';

  // 다이나믹 타입 - 필요할때만 쓰기
  var dynamicname;
  dynamicname = 12;
  dynamicname = true;
  if (dynamicname is int) {
    // dynamicname
  }

  // nullable
  String? nico = 'nico';
  nico = null;
  nico?.isNotEmpty;

  final immutableName = 'nico'; // final String immutableName = ''
  // immutableName = 'like as const';

  // late with final or var
  // 초기 데이터없이 변수 선언 가능
  late final String lateName;
  // ! do somethig, go to api
  // print(lateName) // 안됨 cause unasiggn
  lateName = 'nico';

  // const : compile-time constant를 만들어줌
  const conName = 'nico';
  // should be known as compile type, when user running device
  // app을 앱스토어에 올리기 전에 값을 알고 있어야 하는 값.
  // 어떤값인지 모르고 화면에서 사용자가 입력해야한다면 final이나 var를 써야함.
  // 앱에서 사용할 상수
  const API = '12121212'; // hardcoding
  // fetchAPI를 모르므로 final이 됨
  final APIR = fetchApi();
}

void fetchApi() {
  //
}
