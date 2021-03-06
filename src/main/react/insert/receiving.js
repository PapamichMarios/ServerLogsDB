import React from 'react';

import parser from '../utils/timestamp/parser';
import postRequest from '../utils/requests/postRequest';
import LoadingButton from '../utils/loading/loadingButton';
import Loading from '../utils/loading/loading';
import * as Constants from '../utils/constants';

import { Container, Row, Col, Card, Form, InputGroup, Button, Alert } from 'react-bootstrap';

export default class Receiving extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            timestamp: '',
            source_ip: '',

            block_id: '',
            destination_ip: '',

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
            block_id: this.state.block_id,
            destination_ip: this.state.destination_ip
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
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Insert Receiving Log </Card.Header>

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
                                        <Form.Label column md="6"> <b>Block ID:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="block_id"
                                                onChange={this.onChange}
                                            />
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="6"> <b>Destination IP:</b> </Form.Label>
                                        <Col>
                                            <Form.Control
                                                type="text"
                                                name="destination_ip"
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

Receiving.defaultProps = {
    method: 'POST',
    action: '/insertReceiving'
};