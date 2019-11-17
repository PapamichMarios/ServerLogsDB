import React from 'react';

import LoadingButton from './utils/loading/loadingButton.js';
import * as Constants from './utils/constants';

import { Container, Row, Col, Alert, Button, Card, Form, InputGroup } from 'react-bootstrap';
import { FaUser, FaLock } from 'react-icons/fa';

export default class LogIn extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            username: '',
            password: '',

            hasError: false,
            errorMsg: '',
            loading: false
        }

        this.onChange = this.onChange.bind(this);
        this.onSubmit = this.onSubmit.bind(this);
    }

    onChange(e) {
        this.setState({
            [e.target.name]: e.target.value
        });
    }

    onSubmit(e) {
        e.preventDefault();
        this.setState({loading: true});

        //make the request
        fetch(this.props.action, {
            headers: {
                'Accept' : 'application/json',
                'Content-type': 'application/json'
            },
            method: this.props.method,
            body: JSON.stringify({
                username: this.state.username,
                password: this.state.password
            })
        })
        .then(response => response.json())
        .then(response => {
            if(response.error) {
                this.setState({
                    hasError: true,
                    errorMsg: response.message,
                    loading: false
                })
            } else {
                //add token to session
                localStorage.setItem('accessToken', response.accessToken);
                localStorage.setItem('tokenType', response.tokenType);
                localStorage.setItem('username', response.username);

                //add logged in
                localStorage.setItem('loggedIn', 'true');

                //redirect
                setTimeout( () => {
                    this.props.history.push({
                        pathname: '/welcome',
                        state: {
                            msg: "You have successfully logged in."
                        }
                    });
                    location.reload();
                }, Constants.TIMEOUT_DURATION);
            }
        })
        .catch(error => console.error('Error: ' + error));
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col md={{span: '6', offset: '3'}}>

                        {/* success msg for sign up */}
                        {this.props.location.state !=undefined && (
                            <Alert variant="success">
                                <p>
                                    {this.props.location.state.msg}
                                </p>
                            </Alert>
                        )}

                        <Card border="dark">
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Login </Card.Header>

                            <Card.Body>
                                <Form
                                    action={this.props.action}
                                    method={this.props.method}
                                    onSubmit={this.onSubmit}
                                >

                                    <Form.Group controlId="formUsername">
                                      <InputGroup>
                                        <InputGroup.Prepend>
                                          <InputGroup.Text> <FaUser/> </InputGroup.Text>
                                        </InputGroup.Prepend>
                                        <Form.Control
                                            type="text"
                                            name="username"
                                            placeholder="Username"
                                            onChange={this.onChange}
                                        />
                                      </InputGroup>
                                    </Form.Group>

                                    <Form.Group controlId="formPassword">
                                      <InputGroup>
                                        <InputGroup.Prepend>
                                          <InputGroup.Text> <FaLock/> </InputGroup.Text>
                                        </InputGroup.Prepend>
                                        <Form.Control
                                            type="password"
                                            name="password"
                                            placeholder="Password"
                                            onChange={this.onChange}
                                        />
                                      </InputGroup>
                                    </Form.Group>

                                    {(this.state.loading ? (
                                        <Button variant="dark" block disabled>
                                            <b> Loading </b>
                                            <LoadingButton />
                                        </Button>
                                    ) : (
                                        <Button type="submit" variant="dark" block>
                                            <b> Submit </b>
                                        </Button>
                                    ))}

                                    <br />

                                    {this.state.hasError && (
                                        <Alert variant="danger">
                                            <p> {this.state.errorMsg} </p>
                                        </Alert>
                                    )}

                                </Form>
                            </Card.Body>
                        </Card>
                    </Col>
                </Row>
            </Container>
        );
    }

}

LogIn.defaultProps = {
    method: 'POST',
    action: '/login'
};