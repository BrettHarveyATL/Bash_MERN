#!/bin/bash


touch newdata.txt
echo "<<----------------------->>"
read -p "Name attribute: " input
echo "<<----------------------->>"
#makes all input lowercase
attribute_name=${input,,}
echo "<<----------------------->>"
read -p "What type is it? Examples s for String, n for number, b for Boolean: " type_attr
if [[ $type_attr =~ ^[sS]$ ]]
    then
    input_type=String
elif [[ $type_attr =~ ^[nN]$ ]]
    then
    input_type=Number
elif [[ $type_attr =~ ^[bB]$ ]]
    then
    input_type=Boolean
fi
echo "<<----------------------->>"
read -p "Is it required? Enter 'y' for yes ?: " -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]
    then
    echo "<<----------------------->>"
    read -p "Would like to enter a message to the client if no input is entered? Enter 'y' for yes ?:"  -n 1 -r
    echo "<<----------------------->>"
    if [[ $REPLY =~ ^[yY]$ ]]
        then
        echo "<<----------------------->>"
        read -p "Please enter your string (no need for ''): " require_message
        echo "<<----------------------->>"
        message="require: [true, '$require_message'],"
    else
        message="require: [true],"
    fi
fi
echo "<<----------------------->>"
read -p "Would you like to add mininum length validator, enter y for yes?" -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]
    then
    echo "<<----------------------->>"
    read -p "What is the number of mininum characters required?: " min_length
    re='^[0-9]+$'
    if ! [[ $min_length =~ $re ]] ; then
    echo "error: Not a number, recreate this attribute and try again!" >&2; exit 1
    else min_length_value="minlength: ${min_length},"
fi
fi
cat >> newdata.txt << EOL
$attribute_name :{ 
    type: $input_type,
    $message 
    $min_length_value 
    },
EOL
sed -i '/new data/ r newdata.txt' server/models/${model_name}.model.js
rm newdata.txt

cat >> client/src/views/All${model_name^}s.js << EOL
import React from 'react';
import {Link} from "@reach/router"

const All${model_name^}s = props => {
    return (
        <div>
            <h1>All ${model_name^}s</h1>
            <div>
                <Link to="/${model_name}/new" className="btn btn-primary">Create New ${model_name^}</Link>
            </div>
            <table className="">
                <thead>
                    <th>Name</th>
                    <th>Genre</th>
                    <th>Albums</th>
                </thead>
                <tbody>
                {
                    props.${model_name}s.map((${model_name}, key) => {
                        return <tr key={key}><td>{${model_name}.name}</td> <td>{${model_name}.genre}</td><button onClick={()=>props.onDeleteHander(${model_name}._id)} className="btn btn-danger">Delete</button></tr>
                    })
                }
                </tbody>
            </table>
        </div>
    )
}

export default All${model_name^}s;
EOL

cat >> newdata.txt << EOL
        <All${model_name^}s ${model_name}s={${model_name}}s onDeleteHander={onDeleteHander}/>
EOL
sed -i '/new route/ r newdata.txt' client/src/App.js
rm newdata.txt

cat >> newdata.txt << EOL
    const onDeleteHander = _id =>{
        axios.delete("http://localhost:8000/api/${model_name}s/"+_id)
            .then(res=>{
            console.log(res)
            setLoaded(false);
        })
        .catch(err => console.log(err))
    }
EOL
sed -i '/new handler/ r newdata.txt' client/src/App.js
rm newdata.txt

cat >> newdata.txt << EOL
import All${model_name^}s from './views/All${model_name^}s':
EOL
sed -i '/new import/ r newdata.txt' client/src/App.js
rm newdata.txt

cat >> newdata.txt << EOL
const [${model_name}, set${model_name^}s] = useState([]);
EOL
sed -i '/new state/ r newdata.txt' client/src/App.js
rm newdata.txt
const [artists, setArtists] = useState([]);