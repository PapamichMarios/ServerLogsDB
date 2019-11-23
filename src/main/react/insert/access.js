import React from 'react';

import parser from '../utils/timestamp/parser';
import postRequest from '../utils/requests/postRequest';
import LoadingButton from '../utils/loading/loadingButton';
import Loading from '../utils/loading/loading';
import * as Constants from '../utils/constants';

import { Container, Row, Col, Card, Form, InputGroup, Button, Alert } from 'react-bootstrap';

export default class Access extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            timestamp: '',
            source_ip: '',

            http_method: '',
            http_response: '',
            referer: '',
            resource: '',
            size: '',
            user_agent: '',
            user_id: '',

            loading: '',

            success: false,
            successMsg: '',

            hasError: false,
            errorMsg: ''
        }

        this.onChange = this.onChange.bind(this);
        this.onSubmit = this.onSubmit.bind(this);
    }

    onChange(e){
        this.setState({
            [e.target.name]: e.target.value
        });
    }

    onSubmit(e) {
        e.preventDefault();

        this.setState({ loading: true })


        //fetch the request
        const timestamp = parser(this.state.timestamp);
        const bodyObj = {
            timestamp: timestamp[0] + ' ' + timestamp[1],
            source_ip: this.state.source_ip,
            http_method: this.state.http_method,
            http_response: this.state.http_response,
            referer: this.state.referer,
            resource: this.state.resource,
            size: this.state.size,
            user_agent: this.state.user_agent,
            user_id: this.state.user_id
        };

        postRequest(this.props.action, bodyObj)
        .then(response => {

            if(response.error) {
                this.setState({
                    hasError: true,
                    errorMsg: response.message,
                    loading:false
                });
            } else {
                this.setState({
                    success: true,
                    successMsg: response.message,
                    loading: false
                });
            }
        })
        .catch(error => console.error('Error:' , error));

    }

    render() {
        return (
            <Container>
                <Row>
                    <Col>
                        <Card>
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Insert Access Log </Card.Header>

                            <Card.Body>
                                <Form
                                    action={this.props.action}
                                    method={this.props.method}
                                    onSubmit={this.onSubmit}
                                >
                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>Timestamp:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="datetime-local"
                                                step="1"
                                                name="timestamp"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>Source IP:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="source_ip"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>HTTP Method:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="http_method"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>HTTP Response:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="http_response"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>Referer:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="referer"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>Resource:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="resource"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>Size:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="number"
                                                name="size"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>User Agent String:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="user_agent"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>User ID:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="user_id"
                                                onChange={this.onChange}
                                            />
                                        </Col>
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

                                    <br />

                                    {this.state.success && (
                                        <Alert variant="success">
                                            <p> {this.state.successMsg} </p>
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

Access.defaultProps = {
    method: 'POST',
    action: '/insertAccess'
};