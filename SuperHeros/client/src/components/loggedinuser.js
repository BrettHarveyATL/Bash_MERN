import React, { useState } from 'react';

const LoggedUser = (props) => {
    return(
        <div>
            <h6>This is where the logged in user's username should be displayed</h6>
            {
                props.activeUser ? <h4>{props.activeUser.username}</h4> : ""
            }
            
        </div>
    )
}

export default LoggedUser;
