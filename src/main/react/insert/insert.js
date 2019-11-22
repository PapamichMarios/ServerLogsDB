import React from 'react';

import { Container, Row, Col, Card, Button } from 'react-bootstrap';


export default class Insert extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col>
                        <Card>
                            <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Choose the type of log to insert. </Card.Header>

                            <Card.Body>
                                <Row>
                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/insert/access')} }
                                        >
                                            <b> Access </b>
                                        </Button>
                                    </Col>

                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/insert/received')} }
                                        >
                                            <b> Received </b>
                                        </Button>
                                    </Col>

                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/insert/receiving')} }
                                        >
                                            <b> Receiving </b>
                                        </Button>
                                    </Col>
                                </Row>

                                <Row>
                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/insert/served')} }
                                        >
                                            <b> Served </b>
                                        </Button>
                                    </Col>

                                     <Col>
                                         <Button
                                             size="lg"
                                             block
                                             style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                             variant="dark"
                                             onClick={ () => {this.props.history.push('/insert/replicate')} }
                                         >
                                             <b> Replicate </b>
                                         </Button>
                                     </Col>

                                    <Col>
                                        <Button
                                            size="lg"
                                            block
                                            style={{height: '150px', marginBottom: '5px', marginTop: '5px'}}
                                            variant="dark"
                                            onClick={ () => {this.props.history.push('/insert/delete')} }
                                        >
                                            <b> Delete </b>
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