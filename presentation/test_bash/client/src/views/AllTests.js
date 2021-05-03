import React, { useEffect, useState } from 'react';
import axios from 'axios';

const OneSingleTest= props =>{
    const [test, setTest] = useState({});
    useEffect(()=>{
        axios.get('http://localhost:8000/api/test/'+props.id)
            .then(res=> setTest(res.data.test))
            .catch(err=> console.log(err))
    }, [props.id])

    return(
        <div>
            <h1>All Tests</h1>
            <table className="">
                <thead>

                    {/* new th */}

                </thead>
                <tbody>
                {
                    props.tests.map((test, key) => {
                        return <tr key={key}> 

                        {/* new td */}

                        <button onClick={()=>props.onDeleteHander(test._id)} className="btn btn-danger">Delete</button></tr>
                    })
                }
                </tbody>
            </table>
        </div>
    )
}

export default OneSingleTest;
            <td>{test.name}</td> 
            <th>{test.name}</th> 
            <td>{test.age}</td> 
            <th>{test.age}</th> 
