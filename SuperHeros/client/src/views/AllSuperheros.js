import React, { useEffect, useState } from 'react';
import axios from 'axios';

const OneSingleSuperhero= props =>{
    const [superhero, setSuperhero] = useState({});
    useEffect(()=>{
        axios.get('http://localhost:8000/api/superhero/'+props.id)
            .then(res=> setSuperhero(res.data.superhero))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            <h1>All Superheros</h1>
            <table className="">
                <thead>

                    {/* new th */}
                    <th>{superhero.name}</th>
                    <th>{superhero.power}</th> 
                </thead>
                <tbody>
                {
                    props.superheros.map((superhero, key) => {
                        return <tr key={key}> 

                        {/* new td */}
                        <td>{superhero.power}</td> 
                        <td>{superhero.name}</td> 
                        <button onClick={()=>props.onDeleteHander(superhero._id)} className="btn btn-danger">Delete</button></tr>
                    })
                }
                </tbody>
            </table>
        </div>
    )
}

export default OneSingleSuperhero;
