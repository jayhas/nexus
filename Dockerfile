FROM tomcat:8.0-alpine


ADD *.war /usr/local/tomcat/webapps/
COPY host-manager-context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
EXPOSE 8080

CMD ["catalina.sh", "run"]
