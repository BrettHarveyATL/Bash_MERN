import React, { useEffect, useState } from 'react';
import axios from 'axios';

const oneSingleSuperhero= props =>{
    const [superhero, setSuperhero] = useState;
    useEffect(()=>{
        axios.get('http://localhost:8000/api/superhero/'+props.id)
            .then(res=> setSuperhero(res.data.superhero))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            {/* //new h1*/}
        </div>
    )
}

export default oneSingleSuperhero;
