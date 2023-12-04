psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5


if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters"
    exit 1
fi


vmstat_mb=$(vmstat --unit M)
hostname=$(hostname -f)

memory_free=$(echo "$vmstat_mb" | awk '{print $4}'| tail -n1 | xargs)
cpu_idle=$(echo "$vmstat_mb" | awk '{print $15}' | tail -n1 | xargs)
cpu_kernel=$(echo "$vmstat_mb" | awk '{print $14}' | tail -n1 | xargs)
disk_io=$(vmstat -d | awk '{print $10}' | tail -n1 | xargs)
#disk_available=$(df -BM / | awk '{print $4}')
disk_available=$(df -BM / | awk 'NR == 2 {print $4}' | grep -o '[0-9]\+' | xargs)



timestamp=$(vmstat -t | awk '{print $18, $19}' | tail -n1)



#host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";


insert_stmt="INSERT INTO host_usage(timestamp, host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available) VALUES('$timestamp', (SELECT id FROM host_info WHERE hostname='$hostname'), '$memory_free', '$cpu_idle', '$cpu_kernel', '$disk_io', '$disk_available')";

#set up env var for pql cmd
export PGPASSWORD=$psql_password
#Insert date into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?