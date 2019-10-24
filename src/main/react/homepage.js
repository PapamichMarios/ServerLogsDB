import React from 'react';
import { Container } from 'react-bootstrap';

export default class Home extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
        return(
            <Container>
                <h1> Sup </h1>
            </Container>
        );
    }
}