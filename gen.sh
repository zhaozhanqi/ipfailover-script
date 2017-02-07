#! /bin/sh

serviceip=`oc get svc router | tail -1 | awk '{ print $2 }'`
echo "</dev/tcp/${serviceip}/80" > /root/check.sh

cat <<EOF > notify.sh
#!/bin/bash




TYPE=\$1 
NAME=\$2 
STATE=\$3 

case \$STATE in 
"MASTER") echo "master" >>/tmp/test 
;; 
"BACKUP")echo "slave" >>/tmp/test


;; 
"FAULT") echo "fail" >>/tmp/test


;; 
*) echo "unknown state" 
exit 1 
;; 
esac

EOF
