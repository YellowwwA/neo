import React from 'react'

function Hello({ name, color, isSpecial }) {
    return (<div>
        <div style={{ color }}>{isSpecial && <b>*</b>}Hello~{name}</div>
        <div style={{ color }}>hihi~ {name}</div>
    </div>
    );
}

Hello.defaultProps = {
    name: 'NoName',
}

export default Hello;