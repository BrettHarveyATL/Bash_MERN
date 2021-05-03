#!/bin/bash

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
#<-------------------------------------------THIS IS THE Start of the issue------------------------------>
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

touch newdata.txt
cat >> newdata.txt << EOL
$attribute_name :{ 
    type: $input_type,
    $message 
    $min_length_value 
    },
EOL
sed -i '/new data/ r newdata.txt' server/models/${model_name}.model.js
rm newdata.txt
# echo "You found it" | grep "new td" client/src/views/All${model_name^}s.js
touch newdata.txt
cat >> client/src/views/All${model_name^}s.js << EOL
            <td>{${model_name}.${attribute_name}}</td> 
EOL
sed -i '/new td/ r newdata.txt' client/src/views/All${model_name^}s.js
rm newdata.txt

touch newdata.txt
cat >> client/src/views/All${model_name^}s.js << EOL
            <th>{${model_name}.${attribute_name}}</th> 
EOL
sed -i '/new th/ r newdata.txt' client/src/views/All${model_name^}s.js
rm newdata.txt