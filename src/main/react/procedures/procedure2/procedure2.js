import React from 'react';

import Procedure2Results from './procedure2Results';
import parser from '../../utils/timestamp/parser';
import getRequest from '../../utils/requests/getRequest';
import LoadingButton from '../../utils/loading/loadingButton';
import Loading from '../../utils/loading/loading';
import * as Constants from '../../utils/constants';

import { Container, Row, Col, Card, Form, Button, InputGroup } from 'react-bootstrap';
import { FaCalendar, FaHistory } from 'react-icons/fa';

export default class Procedure2 extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            dateFrom: '2014-10-24T20:36:00',
            dateTo: '2019-10-24T20:36:00',

            type: 'access',

            results: [],

            loading: false
        }

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

        this.setState({ loading: true });

        //parse the datetime-local input
        const from = parser(this.state.dateFrom);
        const to = parser(this.state.dateTo);

        const type = this.state.type;

        //fetch procedure
        const url = this.props.action
            + 'from=' + from[0] + ' ' + from[1]
            + '&to=' + to[0] + ' ' + to[1]
            + '&type=' + type;

        getRequest(url)
            .then(response => {

                console.log(response);
                if(!response.error) {
                    this.setState({
                        results: response.result
                    }, () => {
                        setTimeout( () => {
                            this.setState({
                                loading: false
                            });
                        }, Constants.TIMEOUT_DURATION);
                    });
                }
            })

    }

    render() {
        return (
            <Container>
                <Row>
                    <Col md={{span: '6', offset: '3'}}>
                        <Card border="dark">
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Procedure 2 </Card.Header>

                            <Card.Body>

                                <Card.Text>
                                    2. Find the total logs per day for a specific action type and time range.
                                </Card.Text>

                                <Form
                                    action={this.props.action}
                                    method={this.props.method}
                                    onSubmit={this.onSubmit}
                                >
                                    <Form.Group as={Row}>
                                        <Form.Label column md="4"> <b>From:</b> </Form.Label>

                                        <Col md={8}>
                                            <InputGroup>
                                                <Form.Control
                                                    type="datetime-local"
                                                    step="1"
                                                    name="dateFrom"
                                                    onChange={this.onChange}
                                                    placeholder="2014-10-24T20:36:00"
                                                />
                                                <InputGroup.Append>
                                                    <InputGroup.Text> <FaCalendar/> </InputGroup.Text>
                                                </InputGroup.Append>
                                            </InputGroup>
                                        </Col>

                                    </Form.Group>


                                    <Form.Group as={Row}>
                                        <Form.Label column md="4"> <b>To:</b> </Form.Label>

                                        <Col md={8}>
                                            <InputGroup>
                                                <Form.Control
                                                    type="datetime-local"
                                                    step="1"
                                                    name="dateTo"
                                                    onChange={this.onChange}
                                                    placeholder="2019-10-24T20:36:00"
                                                />
                                                <InputGroup.Append>
                                                    <InputGroup.Text> <FaCalendar/> </InputGroup.Text>
                                                </InputGroup.Append>
                                            </InputGroup>
                                        </Col>
                                    </Form.Group>

                                    <Form.Group as={Row}>
                                        <Form.Label column md="4"> <b>Type:</b> </Form.Label>

                                        <Col md={8}>
                                            <InputGroup>
                                                <Form.Control
                                                    type="text"
                                                    name="type"
                                                    onChange={this.onChange}
                                                />
                                                <InputGroup.Append>
                                                    <InputGroup.Text> <FaHistory/> </InputGroup.Text>
                                                </InputGroup.Append>
                                            </InputGroup>
                                        </Col>
                                    </Form.Group>

                                    {(this.state.loading) ? (
                                        <Button variant="dark" block disabled>
                                            <b> Loading </b>
                                            <LoadingButton />
                                        </Button>
                                    ) : (
                                        <Button type="submit" variant="dark" block>
                                            <b> Submit </b>
                                        </Button>
                                    )}

                                </Form>
                            </Card.Body>
                        </Card>
                    </Col>
                </Row>


                <br />
                <br />

                {/* present results */}

                {this.state.loading ? (
                    <Loading />
                ) : (
                    <Procedure2Results results={this.state.results} />
                )}

            </Container>
        );
    }
}

Procedure2.defaultProps = {
    method: 'GET',
    action: '/executeProcedure2?'
}