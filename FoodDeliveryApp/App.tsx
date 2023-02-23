import * as React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {Provider} from 'react-redux';
import store from './src/store';
import AppInner from './AppInner';

function App() {
  return (
    <Provider store={store}>
      <NavigationContainer>
        <AppInner />
      </NavigationContainer>
    </Provider>
  );
}

export default App;
// function Stack(){
//   return <View></View>
// }
// function Navigator(){
//   return <View></View>
// }
// function Screen(){
//   return <View></View>
// }

// Stack.Navigator = Navigator
// Stack.Screen = Screen
