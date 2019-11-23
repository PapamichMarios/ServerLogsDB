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
import Procedure1 from './procedure1/procedure1';
import Procedure2 from './procedure1/procedure2';
import Procedure3 from './procedure1/procedure3';

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
                    <Route exact path="/insert-log" component={Insert} />

                    {/* procedures */}
                    <Route exact path="/procedure1" component={Procedure1} />
                    <Route exact path="/procedure2" component={Procedure2} />
                    <Route exact path="/procedure3" component={Procedure3} />

                    {/* insert logs */}
                    <Route exact path="/insert/access" component={Access} />
                    <Route exact path="/insert/received" component={Received} />
                    <Route exact path="/insert/receiving" component={Receiving} />
                    <Route exact path="/insert/served" component={Served} />
                    <Route exact path="/insert/replicate" component={Replicate} />
                    <Route exact path="/insert/delete" component={Delete} />
                </Switch>
            </div>
        );
    }
}

export default withRouter(App);