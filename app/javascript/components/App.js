import React from "react"
import { BrowserRouter, Switch, Route } from 'react-router-dom'
import { Provider } from 'react-redux'
import Deals from './Deals'
import configureStore from '../configureStore'

const store = configureStore();

class App extends React.Component {
  render () {
    return (
      <Provider store={store}>
        <BrowserRouter>
          <Switch>
            <Route exac path="/" render={() => <Deals />} />
          </Switch>
        </BrowserRouter>
      </Provider>
    );
  }
}

export default App
