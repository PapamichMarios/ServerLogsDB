import React from 'react';

import { Container, Row, Col, Card, Button } from 'react-bootstrap';
import { withRouter } from 'react-router-dom';

class Search extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col>
                        <Card>
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Choose the type of IP you want to search. </Card.Header>

                            <Card.Body>
                                <Row>
                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/search/source')} }
                                        >
                                            <b> Source IP </b>
                                        </Button>
                                    </Col>

                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/search/destination')} }
                                        >
                                            <b> Destination IP </b>
                                        </Button>
                                    </Col>
                                </Row>
                            </Card.Body>
                        </Card>
                    </Col>
                </Row>
            </Container>
        )
    }
}

export default withRouter(Search);