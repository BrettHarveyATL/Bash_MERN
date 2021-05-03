import React, { useEffect, useState } from 'react';
import axios from 'axios';

const OneSingleProducts= props =>{
    const [products, setProducts] = useState({});
    useEffect(()=>{
        axios.get('http://localhost:8000/api/products/'+props.id)
            .then(res=> setProducts(res.data.products))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            <h1>All Productss</h1>
            <table className="">
                <thead>

                    {/* new th */}

                </thead>
                <tbody>
                {
                    props.productss.map((products, key) => {
                        return <tr key={key}> 

                        {/* new td */}

                        <button onClick={()=>props.onDeleteHander(products._id)} className="btn btn-danger">Delete</button></tr>
                    })
                }
                </tbody>
            </table>
        </div>
    )
}

export default OneSingleProducts;
            <td>{products.productname}</td> 
            <th>{products.productname}</th> 
            <td>{products.type}</td> 
            <th>{products.type}</th> 
            <td>{products.price}</td> 
            <th>{products.price}</th> 
