import React from 'react';

import { Row, Col, Card, Table, Alert } from 'react-bootstrap';

export default class Procedure1Results extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {

        let queryResults = [];
        this.props.results.map( (result, index) => {
            queryResults.push(
                <tr key={index}>
                    <td> {result[0]} </td>
                    <td> {result[1]} </td>
                </tr>
            );
        });

        return (
            <Row>
                <Col>
                    <Card border="dark">
                        <Card.Header as="h3" className="text-center bg-dark" style={{color:'white'}}> Procedure 1 Results</Card.Header>

                        <Card.Body>

                            {queryResults.length === 0 ? (
                                <Alert variant="info">
                                    <p>
                                        <b> No results yet. </b>
                                    </p>
                                </Alert>
                            ) : (
                                <Table striped hover>
                                    <thead>
                                        <tr>
                                            <th> Type </th>
                                            <th> Total </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        {queryResults}
                                    </tbody>
                                </Table>
                            )}

                        </Card.Body>
                    </Card>
                </Col>
            </Row>
        )
    }
}