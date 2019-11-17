import React from 'react';

import { NavLink, Link, withRouter } from "react-router-dom";
import { Navbar, Nav, NavItem, NavDropdown, Button } from 'react-bootstrap';
import { FaHome, FaSignInAlt, FaSignOutAlt } from 'react-icons/fa';

class NavBar extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {

        const navLeft = (
            <Nav className="mr-auto">
              <NavItem className="button-margin-left">
                <Link to="/function">
                    <Button title="Function 1" variant="dark" style={{borderRadius: '12px'}}>
                        Function 1
                    </Button>
                </Link>
              </NavItem>
            </Nav>
        );

        let navRight;
        if (localStorage.getItem('loggedIn') === 'true') {
            navRight = (
                <Nav className="justify-content-end">
                    <NavItem className="button-margin">
                      <NavLink to="/home">
                          <Button title="Home" variant="dark" style={{borderRadius: '12px'}}>
                            <FaHome style={{verticalAlign: 'baseline'}} />
                          </Button>
                      </NavLink>
                    </NavItem>

                    <NavItem className="button-margin">
                       <Button title="Log Out" variant="outline-danger" onClick={this.props.onLogout} style={{borderRadius: '12px'}}>
                        <b> Logout </b> <FaSignOutAlt style={{verticalAlign: 'baseline'}} />
                       </Button>
                    </NavItem>
                </Nav>
            );
        } else {
            navRight = (
                <Nav className="justify-content-end">
                    <NavItem className="button-margin">
                      <NavLink to="/home">
                          <Button title="Home" variant="dark" style={{borderRadius: '12px'}}>
                            <FaHome style={{verticalAlign: 'baseline'}} />
                          </Button>
                      </NavLink>
                    </NavItem>

                    <NavItem className="button-margin">
                      <NavLink to="/login">
                           <Button title="Log In" variant="outline-light" style={{borderRadius: '12px'}}>
                           <b> Login </b> <FaSignInAlt style={{verticalAlign: 'baseline'}} />
                           </Button>
                      </NavLink>
                    </NavItem>

                    <NavItem className="button-margin" >
                      <NavLink to="/signup">
                          <Button title="Sign Up" variant="dark" style={{borderRadius: '12px'}}>
                            <b> Signup </b>
                          </Button>
                      </NavLink>
                    </NavItem>
                </Nav>
            );
        }

        return (
             <Navbar bg="dark" variant="dark" style={{marginBottom: '15px'}}>
                  <Navbar.Brand href="/welcome"> <b> LogDB </b> </Navbar.Brand>
                  <Navbar.Toggle aria-controls="basic-navbar-nav" />
                  <Navbar.Collapse id="basic-navbar-nav">

                  {navLeft}

                  {navRight}

                  </Navbar.Collapse>
              </Navbar>
        );
    }
}

export default withRouter(NavBar);