import React, { useEffect, useState } from 'react';
import axios from 'axios';

const oneSingleProducts= props =>{
    const [products, setProducts] = useState;
    useEffect(()=>{
        axios.get('http://localhost:8000/api/products/'+props.id)
            .then(res=> setProducts(res.data.products))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            {/* //new h1*/}
        </div>
    )
}

export default oneSingleProducts;
