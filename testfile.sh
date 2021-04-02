#!/bin/bash
touch newdata.txt
cat >> newdata.txt << EOL
some new data
EOL
sed -i '/new data/ r newdata.txt' test_bash/server/routes/user.routes.js
rm newdata.txt