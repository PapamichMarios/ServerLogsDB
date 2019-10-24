import React from 'react';

import Home from './homepage';

import { BrowserRouter as Router, Switch, Route, withRouter, Redirect } from 'react-router-dom';

class App extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                <Switch>
                    <Route exact path="/"           component={Home} />
                    <Route exact path="/welcome"    component={Home} />
                    <Route exact path="/home"       component={Home} />
                </Switch>
            </div>
        );
    }
}

export default withRouter(App);