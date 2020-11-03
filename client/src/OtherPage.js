import React from 'react';
import { Link } from 'react-router-dom';

const func = () => {
    return (
        <div>
            I'm some other page!
            <Link to="/">Home</Link>
        </div>
    );
};

export default func;