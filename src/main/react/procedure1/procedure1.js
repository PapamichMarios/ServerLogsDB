import React from 'react';

import getRequest from './utils/requests/getRequest';
import LoadingButton from './utils/loading/loadingButton';

import { Container, Row, Col, Card, Form, Button } from 'react-bootstrap';


export default class Procedure1 extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            dateFrom: ''
            dateTo: ''
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


    }

    render() {
        return (
            <Container>
                <Row>
                    <Col md={{span: '6', offset: '3'}}>
                        <Card border="dark">
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Procedure 1 </Card.Header>

                            <Card.Body>
                                <Form
                                    action={this.props.action}
                                    method={this.props.method}
                                    onSubmit={this.onSubmit
                                >

                                    <Card.Text>
                                      1. Find the total logs per type that were created within a specified time range
                                      and sort them in a descending order. Please note that individual files may log
                                      actions of more than one type.
                                    </Card.Text>

                                    <Form.Group>
                                        <InputGroup>
                                            <InputGroup.Prepend>
                                                <InputGroup.Text> <FaCalendar/> </InputGroup.Text>
                                             </InputGroup.Prepend>

                                            <Form.Label> From: </Form.Label>
                                            <Form.Control
                                                type="date"
                                                name="dateFrom"
                                                onChange={this.onChange}
                                            />
                                        </InputGroup>
                                    </Form.Group>


                                    <Form.Group>
                                        <InputGroup>
                                            <InputGroup.Prepend>
                                                <InputGroup.Text> <FaCalendar/> </InputGroup.Text>
                                            </InputGroup.Prepend>

                                            <Form.Label> To: </Form.Label>
                                            <Form.Control
                                                type="date"
                                                name="dateTo"
                                                onChange={this.onChange}
                                            />
                                        </InputGroup>
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


                {/* present results */}
                <Row>
                    <Col>
                        <Card border="dark">
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Procedure 1 Results</Card.Header>

                            <Card.Body>

                            </Card.Body>
                        </Card>
                    </Col>
                </Row>
            </Container>
        );
    }
}