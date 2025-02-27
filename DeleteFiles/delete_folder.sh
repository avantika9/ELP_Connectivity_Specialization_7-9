echo "Submitting jobs for ID list from idfile.txt"
echo
while read id; do
  if [[ ! -z "$id" ]];
  then 
  subject_id="${id}"
# cd to subject path 
  cd /gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed/;
  cd $subject_id;
  echo "Submitting job for Subject ID ${subject_id}"
# find and delete files taht hav ethe   
  find . -name 'ses9_analysis' -exec rm -rf {} \;
  fi
done <idfile.txt
