import React from 'react';

import { NavLink, Link, withRouter } from "react-router-dom";
import { Navbar, Nav, NavItem, NavDropdown, Button } from 'react-bootstrap';
import { FaHome, FaSignInAlt, FaSignOutAlt, FaPlus } from 'react-icons/fa';

class NavBar extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {

        // for the left part of the navbar
        let navLeft;
        if (localStorage.getItem('loggedIn') === 'true') {
            navLeft = (
                <Nav className="mr-auto">
                  <NavItem className="button-margin-left">
                    <Link to="/procedure1">
                        <Button title="Procedure 1" variant="dark" style={{borderRadius: '12px'}}>
                            <b>Procedure 1</b>
                        </Button>
                    </Link>
                  </NavItem>

                  <NavItem className="button-margin-left">
                    <Link to="/procedure2">
                        <Button title="Procedure 2" variant="dark" style={{borderRadius: '12px'}}>
                            <b>Procedure 2</b>
                        </Button>
                    </Link>
                  </NavItem>

                  <NavItem className="button-margin-left">
                    <Link to="/procedure3">
                        <Button title="Procedure 3" variant="dark" style={{borderRadius: '12px'}}>
                            <b>Procedure 3</b>
                        </Button>
                    </Link>
                  </NavItem>

                  <NavItem className="button-margin-left">
                    <Link to="/SearchSource">
                        <Button title="Search Source" variant="dark" style={{borderRadius: '12px'}}>
                            <b>Search IP (Source)</b>
                        </Button>
                    </Link>
                  </NavItem>

                    <NavItem className="button-margin-left">
                        <Link to="/SearchDestination">
                            <Button title="Search Dest" variant="dark" style={{borderRadius: '12px'}}>
                                <b>Search IP (Dest)</b>
                            </Button>
                        </Link>
                    </NavItem>
                </Nav>
            );
        } else {
            navLeft = (
                <Nav className="mr-auto"> </Nav>
            );
        }

        // for the right part of the navbar
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
                        <NavLink to="/insert-log">
                            <Button title="Insert Log" variant="dark" style={{borderRadius: '12px'}}>
                                <FaPlus style={{verticalAlign: 'baseline'}} />
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