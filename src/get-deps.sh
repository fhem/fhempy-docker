#!/bin/bash

find / -type f -name manifest.json -exec  jq --raw-output -e '.requirements[]' {} + > requirements_deps.txt
sort -u requirements_deps.txt > requirements_uniq.txt 
end=$((SECONDS+50))
while read -r in; do \
    echo "try to build wheel $in"; 
    pip wheel --wheel-dir /wheels --find-links file:///root/.cache/wheels "${in}"
    if [  "${SECONDS}" -gt "${end}" ]; then 
        echo "Time is over, stopping" 
        break 
    fi 
done < requirements_uniq.txt;
exit 0