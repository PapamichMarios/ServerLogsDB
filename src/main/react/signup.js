import React from 'react';

import LoadingButton from './utils/loading/loadingButton.js';
import * as Constants from './utils/constants';

import { Container, Row, Col, Form, Button, Card, InputGroup, Alert } from 'react-bootstrap';
import { FaUser, FaLock, FaEnvelope } from 'react-icons/fa';

export default class SignUp extends React.Component{
    constructor(props) {
        super(props);

        this.state = {
            username: '',
            password: '',
            repeatPassword: '',
            email: '',

            hasError: false,
            errorMsg: '',
            loading: false
        };

        this.onSubmit = this.onSubmit.bind(this);
        this.onChange = this.onChange.bind(this);
    }

    onChange(e){
        this.setState({
            [e.target.name]: e.target.value
        });
    }

    onSubmit(e) {
        e.preventDefault();

        this.setState({loading: true});

        if (this.state.password !== this.state.repeatPassword) {
            this.setState({
                hasError: true,
                errorMsg: 'Passwords given do not match.',
                loading: false
            });
        } else {
            //make the request
            fetch(this.props.action, {
                headers: {
                    'Accept' : 'application/json',
                    'Content-type': 'application/json'
                },
                method: this.props.method,
                body: JSON.stringify({
                    username: this.state.username,
                    email: this.state.email,
                    password: this.state.password
                })
            })
            .then(response => response.json())
            .then(response => {
                if(response.error) {
                    this.setState({
                        hasError: true,
                        errorMsg: response.message
                    })
                } else {
                    //redirect
                    setTimeout( () => {
                        this.props.history.push({
                            pathname: '/login',
                            state: {
                                msg: "You have successfully registered in our system. Please login."
                            }
                        });
                    }, Constants.TIMEOUT_DURATION);
                }
            })
            .catch(error => console.error('Error: ' + error));
        }
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col md={{span: '6', offset: '3'}}>
                        <Card border="dark">
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Signup </Card.Header>

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

                                    <Form.Group controlId="formRepeatPassword">
                                      <InputGroup>
                                        <InputGroup.Prepend>
                                          <InputGroup.Text> <FaLock/> </InputGroup.Text>
                                        </InputGroup.Prepend>
                                        <Form.Control
                                            type="password"
                                            name="repeatPassword"
                                            placeholder="Repeat password"
                                            onChange={this.onChange}
                                        />
                                      </InputGroup>
                                    </Form.Group>

                                    <Form.Group controlId="formEmail">
                                      <InputGroup>
                                        <InputGroup.Prepend>
                                          <InputGroup.Text> <FaEnvelope/> </InputGroup.Text>
                                        </InputGroup.Prepend>
                                        <Form.Control
                                            type="email"
                                            name="email"
                                            placeholder="E-mail Address"
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

SignUp.defaultProps = {
    method: 'POST',
    action: '/signup'
}