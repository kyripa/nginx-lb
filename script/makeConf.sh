#!/bin/bash
port="listen ${NGINX_PORT};"
sed -i "/port/a $port" template


for ((i=1;i <=5;i++ ))
{
	path=`env | grep "PROXY_PATH_$i" | sed -e 's/.*=//'`
	if [ -z "$path" ]; then	continue;fi;
	host=`env | grep "PROXY_HOST_$i" | sed -e 's/.*=//'`	
	if [ -z "$host" ]; then continue;fi;
	location="location /${path}/ {\nproxy_pass http://${host}/;\nproxy_set_header Host           ${host};\n}\n"
	sed -i "/location${i}/a $location" template
}

cp -f template /etc/nginx/nginx.conf
exec nginx
