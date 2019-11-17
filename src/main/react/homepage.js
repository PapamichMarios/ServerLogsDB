import React from 'react';
import { Container, Row, Col, Alert } from 'react-bootstrap';

export default class Home extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
        return(
            <Container>

                {/* success msg for log in */}
                {this.props.location.state !=undefined && (
                    <Alert variant="success">
                        <p>
                            {this.props.location.state.msg}
                        </p>
                    </Alert>
                )}

                <Row>
                    <Col>
                        <h1> Welcome to Log DB! </h1>
                    </Col>
                </Row>
            </Container>
        );
    }
}