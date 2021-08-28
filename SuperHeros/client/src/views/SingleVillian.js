import React, { useEffect, useState } from 'react';
import axios from 'axios';

const oneSingleVillian= props =>{
    const [villian, setVillian] = useState;
    useEffect(()=>{
        axios.get('http://localhost:8000/api/villian/'+props.id)
            .then(res=> setVillian(res.data.villian))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            {/* //new h1*/}
        </div>
    )
}

export default oneSingleVillian;
