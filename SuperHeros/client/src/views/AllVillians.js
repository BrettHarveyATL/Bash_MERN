import React, { useEffect, useState } from 'react';
import axios from 'axios';

const OneSingleVillian= props =>{
    const [villian, setVillian] = useState({});
    useEffect(()=>{
        axios.get('http://localhost:8000/api/villian/'+props.id)
            .then(res=> setVillian(res.data.villian))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            <h1>All Villians</h1>
            <table className="">
                <thead>

                    {/* new th */}
                    <th>{villian.name}</th> 
                </thead>
                <tbody>
                {
                    props.villians.map((villian, key) => {
                        return <tr key={key}> 

                        {/* new td */}
                        <td>{villian.name}</td> 
                        <button onClick={()=>props.onDeleteHander(villian._id)} className="btn btn-danger">Delete</button></tr>
                    })
                }
                </tbody>
            </table>
        </div>
    )
}

export default OneSingleVillian; 
