import React from 'react';

import Home from './homepage';
import NavBar from './navbar';
import SignUp from './signup';
import LogIn from './login';

//insertion
import Insert from './insert/insert';
import Access from './insert/access';
import Replicate from './insert/replicate';
import Delete from './insert/delete';
import Receiving from './insert/receiving';
import Received from './insert/received';
import Served from './insert/served';

// procedures
import Procedure1 from './procedures/procedure1/procedure1';
import Procedure2 from './procedures/procedure2/procedure2';
import Procedure3 from './procedures/procedure3/procedure3';

import Page401 from './errors/error401/error401';
import isAuthenticated from './utils/authentication/isAuthenticated';

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
                    <Route exact path="/"                   component={Home} />
                    <Route exact path="/welcome"            component={Home} />
                    <Route exact path="/home"               component={Home} />

                    <Route exact path="/signup"             component={SignUp} />
                    <Route exact path="/login"              component={LogIn} />

                    <Route exact path="/insert-log"         render={ () => isAuthenticated() ? <Insert />  : <Redirect to="/unauthorized" /> } />

                    {/* procedures */}
                    <Route exact path="/procedure1"         render={ () => isAuthenticated() ? <Procedure1 />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/procedure2"         render={ () => isAuthenticated() ? <Procedure2 />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/procedure3"         render={ () => isAuthenticated() ? <Procedure3 />  : <Redirect to="/unauthorized" /> } />

                    {/* insert logs */}
                    <Route exact path="/insert/access"      render={ () => isAuthenticated() ? <Access />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/insert/received"    render={ () => isAuthenticated() ? <Received />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/insert/receiving"   render={ () => isAuthenticated() ? <Receiving />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/insert/served"      render={ () => isAuthenticated() ? <Served />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/insert/replicate"   render={ () => isAuthenticated() ? <Replicate />  : <Redirect to="/unauthorized" /> } />
                    <Route exact path="/insert/delete"      render={ () => isAuthenticated() ? <Delete />  : <Redirect to="/unauthorized" /> } />

                    <Route exact path="/unauthorized"       component={Page401} />
                </Switch>
            </div>
        );
    }
}

export default withRouter(App);