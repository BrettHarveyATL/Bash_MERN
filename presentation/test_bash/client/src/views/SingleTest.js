import React, { useEffect, useState } from 'react';
import axios from 'axios';

const oneSingleTest= props =>{
    const [test, setTest] = useState;
    useEffect(()=>{
        axios.get('http://localhost:8000/api/test/'+props.id)
            .then(res=> setTest(res.data.test))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            {/* //new h1*/}
        </div>
    )
}

export default oneSingleTest;
