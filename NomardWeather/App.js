import { useEffect, useState } from "react";
import {
  ScrollView,
  StyleSheet,
  Text,
  View,
  Dimensions,
  ActivityIndicator,
} from "react-native";
import { StatusBar } from "expo-status-bar";
import * as Location from "expo-location";
import Ionicons from "@expo/vector-icons/Ionicons";

const { width: SCREEN_WIDTH } = Dimensions.get("window");
const API_KEY = "3f344da20bf99a6563df6e31729445a5";
const icons = {
  Clouds: "cloudy",
  Clear: "sunny",
  Rain: "rainy",
  Atmosphere: "ios-cloudy-night-outline",
  Snow: "snow",
  Drizzle: "airplane",
  Thunderstorm: "thunderstorm",
};

export default function App() {
  const [city, setCity] = useState("Loading...");
  const [days, setDays] = useState([]);
  const [ok, setOk] = useState(true);
  const getWeather = async () => {
    const { granted } = await Location.requestForegroundPermissionsAsync();
    if (!granted) {
      setOk(false);
    }
    const {
      coords: { latitude, longitude },
    } = await Location.getCurrentPositionAsync({
      accuracy: 5,
    });
    const location = await Location.reverseGeocodeAsync(
      //위도와 경도를 주소로 알려줌
      {
        latitude,
        longitude,
      },
      { useGoogleMaps: false }
    );
    setCity(location[0].city);
    const response = await fetch(
      `https://api.openweathermap.org/data/2.5/forecast?lat=${latitude}&lon=${longitude}&appid=${API_KEY}&units=metric`
    );
    const json = await response.json();
    setDays(
      json.list.filter((weather) => {
        if (weather.dt_txt.includes("00:00:00")) {
          return weather;
        }
      })
    );
  };

  useEffect(() => {
    getWeather();
  });
  return (
    <View style={styles.container}>
      <View style={styles.city}>
        <Text style={styles.cityName}>{city}</Text>
      </View>
      {/* scrollview를 쓰려면 propstyle이 아닌, contentcontainerstyle쓰기 */}
      <ScrollView
        pagingEnabled //sticky !
        showsHorizontalScrollIndicator={false}
        horizontal
        contentContainerStyle={styles.weather}
      >
        {days.length === 0 ? (
          <ActivityIndicator
            color="white"
            size="large"
            style={{ ...styles.day, marginTop: 10 }}
          />
        ) : (
          days.map((day, index) => (
            <View key={index} style={styles.day}>
              <View
                style={{
                  flexDirection: "row",
                  alignItems: "center",
                  width: "100%",
                  justifyContent: "space-between",
                }}
              >
                <Text style={styles.temp}>
                  {parseFloat(day.main.temp).toFixed(1)}
                </Text>
                <Ionicons
                  name={icons[day.weather[0].main]}
                  size={24}
                  color="black"
                />
              </View>
              <Text style={styles.description}>{day.weather[0].main}</Text>
              <Text style={styles.tinyText}>{day.weather[0].description}</Text>
            </View>
          ))
        )}
      </ScrollView>
      {/* https://icons.expo.fyi/ */}
      <StatusBar style="light" />
    </View>
  );
}

//flex + background로 공간을 먼저 만들고, 그 후 코드 작성
//Px을 쓰지 않고, flex 비율로 공간 확보
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#c4c9e8",
  },
  city: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  cityName: {
    fontSize: 68,
    fontWeight: "500",
    color: "white",
  },
  weather: {
    // scrollview는 flex가 필요 없음, 스크린보다 나가야해서
  },
  day: {
    //dimensions
    width: SCREEN_WIDTH,
    alignItems: "flex-start",
    paddingHorizontal: 20,
  },
  temp: {
    marginTop: 50,
    fontSize: 100,
    color: "white",
  },
  description: {
    marginTop: -10,
    fontSize: 30,
    color: "white",
    fontWeight: "500",
  },
  tinyText: {
    marginTop: -5,
    fontSize: 25,
    color: "white",
    fontWeight: "500",
  },
});
