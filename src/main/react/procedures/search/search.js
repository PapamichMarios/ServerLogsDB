import React from 'react';

import SearchResults from './searchResults';
import parser from '../../utils/timestamp/parser';
import getRequest from '../../utils/requests/getRequest';
import LoadingButton from '../../utils/loading/loadingButton';
import Loading from '../../utils/loading/loading';
import * as Constants from '../../utils/constants';

import { Container, Row, Col, Card, Form, Button, InputGroup } from 'react-bootstrap';
import { FaCalendar, FaHistory } from 'react-icons/fa';

export default class SearchSource extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            ip: '192.168.1.1',

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
        const ip = this.state.ip;

        //fetch procedure
        const url = this.props.action
            + 'ip=' + ip;

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
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Search By IP </Card.Header>

                            <Card.Body>

                                <Card.Text>
                                    Search by source  IP
                                </Card.Text>

                                <Form
                                    action={this.props.action}
                                    method={this.props.method}
                                    onSubmit={this.onSubmit}
                                >
                                    <Form.Group as={Row}>
                                        <Form.Label column md="4"> <b>IP:</b> </Form.Label>

                                        <Col md={8}>
                                            <InputGroup>
                                                <Form.Control
                                                    type="text"
                                                    name="ip"
                                                    onChange={this.onChange}
                                                    placeholder="192.168.1.1"
                                                />
                                                <InputGroup.Append>
                                                    <InputGroup.Text> <FaCalendar/> </InputGroup.Text>
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
                    <SearchResults results={this.state.results} />
                )}

            </Container>
        );
    }
}

SearchSource.defaultProps = {
    method: 'GET',
    action: '/executeSearchSource?'
}