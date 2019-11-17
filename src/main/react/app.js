import React from 'react';

import Home from './homepage';
import NavBar from './navbar';
import SignUp from './signup';
import LogIn from './login';

import { BrowserRouter as Router, Switch, Route, withRouter, Redirect } from 'react-router-dom';

class App extends React.Component {

    constructor(props) {
        super(props);

        this.handleLogout = this.handleLogout.bind(this);
    }

    handleLogout() {

        //clear the session
        localStorage.clear();

        //redirect
        this.props.history.push("/welcome");
        location.reload();
    }

    render() {
        return (
            <div>
                <NavBar onLogout={this.handleLogout}/>

                <Switch>
                    <Route exact path="/"           component={Home} />
                    <Route exact path="/welcome"    component={Home} />
                    <Route exact path="/home"       component={Home} />

                    <Route exact path="/signup"     component={SignUp} />
                    <Route exact path="/login"      component={LogIn} />
                </Switch>
            </div>
        );
    }
}

export default withRouter(App);