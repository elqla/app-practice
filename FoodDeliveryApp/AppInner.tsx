import messaging from '@react-native-firebase/messaging';
import SignIn from './src/pages/SignIn';
import SignUp from './src/pages/SignUp';
import Orders from './src/pages/Orders';
import Delivery from './src/pages/Delivery';
import Settings from './src/pages/Settings';
import * as React from 'react';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {useSelector} from 'react-redux';
import {RootState} from './src/store/reducer';
import useSocket from './src/hooks/useSocket';
import {useEffect} from 'react';
import EncryptedStorage from 'react-native-encrypted-storage';
import axios, {AxiosError} from 'axios';
import {Alert} from 'react-native';
import userSlice from './src/slices/user';
import {useAppDispatch} from './src/store';
import Config from 'react-native-config';
import orderSlice from './src/slices/order';
import usePermissions from './src/hooks/usePermissions';
import SplashScreen from 'react-native-splash-screen';
import FontAwesomeIcon from 'react-native-vector-icons/FontAwesome';

export type LoggedInParamList = {
  Orders: undefined;
  Settings: undefined;
  Delivery: undefined;
  Complete: {orderId: string};
};
export type RootStackParamList = {
  SignIn: undefined;
  SignUp: undefined;
};
const Tab = createBottomTabNavigator();
const Stack = createNativeStackNavigator<RootStackParamList>();

function AppInner() {
  const dispatch = useAppDispatch();
  const isLoggedIn = useSelector((state: RootState) => !!state.user.email);
  console.log('isLoggedIn', isLoggedIn);

  const [socket, disconnect] = useSocket();

  // usePermissions();

  // 앱 실행 시 토큰 있으면 로그인하는 코드

  // splashscreen
  useEffect(() => {
    const getTokenAndRefresh = async () => {
      try {
        const token = await EncryptedStorage.getItem('refreshToken');
        if (!token) {
          SplashScreen.hide();
          return;
        }

        const response = await axios.post(
          `${Config.API_URL}/refreshToken`,
          {},
          {
            headers: {
              authorization: `Bearer ${token}`,
            },
          },
        );
        dispatch(
          userSlice.actions.setUser({
            name: response.data.data.name,
            email: response.data.data.email,
            accessToken: response.data.data.accessToken,
          }),
        );
      } catch (error) {
        console.error(error);
        if ((error as AxiosError).response?.data.code === 'expired') {
          Alert.alert('알림', '다시 로그인 해주세요.');
        }
      } finally {
        // TODO : 스플래시 스크린 없애기
        SplashScreen.hide();
      }
    };
    getTokenAndRefresh();
  }, [dispatch]);

  useEffect(() => {
    const callback = (data: any) => {
      console.log(data);
      dispatch(orderSlice.actions.addOrder(data));
    };
    if (socket && isLoggedIn) {
      socket.emit('acceptOrder', 'hello');
      socket.on('order', callback);
    }
    return () => {
      if (socket) {
        socket.off('order', callback);
      }
    };
  }, [dispatch, isLoggedIn, socket]);

  useEffect(() => {
    if (!isLoggedIn) {
      console.log('!isLoggedIn', !isLoggedIn);
      disconnect();
    }
  }, [isLoggedIn, disconnect]);

  useEffect(() => {
    axios.interceptors.response.use(
      response => {
        return response;
      },
      async error => {
        const {
          config,
          response: {status},
        } = error;
        if (status === 419) {
          if (error.response.data.code === 'expired') {
            const originalRequest = config;
            const refreshToken = await EncryptedStorage.getItem('refreshToken');
            // token refresh 요청
            const {data} = await axios.post(
              `${Config.API_URL}/refreshToken`, // token refresh api
              {},
              {headers: {authorization: `Bearer ${refreshToken}`}},
            );
            // 새로운 토큰 저장
            dispatch(userSlice.actions.setAccessToken(data.data.accessToken));
            originalRequest.headers.authorization = `Bearer ${data.data.accessToken}`;
            // 419로 요청 실패했던 요청 새로운 토큰으로 재요청
            return axios(originalRequest);
          }
        }
        return Promise.reject(error);
      },
    );
  }, [dispatch]);

  // 토큰 설정 - 푸시알림 관련
  useEffect(() => {
    async function getToken() {
      try {
        // app 처음 설치했을때 실행됨.
        if (!messaging().isDeviceRegisteredForRemoteMessages) {
          // remote message를 위해 기계를 등록함.
          await messaging().registerDeviceForRemoteMessages();
        }
        //token redux 및 서버에 등록 -> puhs알림 보낼때 쓰겠징
        const token = await messaging().getToken();
        console.log('phone token', token);
        dispatch(userSlice.actions.setPhoneToken(token));
        return axios.post(`${Config.API_URL}/phonetoken`, {token});
      } catch (error) {
        console.error(error);
      }
    }
    getToken();
  }, [dispatch]);

  return (
    //  컨테이너 안에서 네비게이션 작동
    //  safeareaview가 적용된것
    isLoggedIn ? (
      <Tab.Navigator>
        {/* Tab.group */}
        <Tab.Screen
          name="Orders"
          component={Orders}
          options={{title: '오더 목록'}}
        />
        <Tab.Screen
          name="Delivery"
          component={Delivery}
          options={{headerShown: false}}
        />
        <Tab.Screen
          name="Settings"
          component={Settings}
          options={{
            title: '내 정보',
            headerTitleStyle: {
              fontSize: 30,
            },
            tabBarIcon: () => <FontAwesomeIcon name="list" />,
            unmountOnBlur: true,
          }}
        />
      </Tab.Navigator>
    ) : (
      // {/* Navigator가 스크린을 그룹으로 묶어줘서, 스크린을 이동할 수 있음. */}
      <Stack.Navigator>
        <Stack.Screen
          // {/* screen안에 넣는것은 navigation, route필수로 써줘야함 */}
          name="SignIn"
          component={SignIn}
          options={{title: '로그인'}}
        />
        <Stack.Screen
          name="SignUp"
          component={SignUp}
          options={{title: '회원가입'}}
        />
      </Stack.Navigator>
    )
  );
}

export default AppInner;
