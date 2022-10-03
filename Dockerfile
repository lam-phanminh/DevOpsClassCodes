FROM tomcat:9-jre11
ADD addressbook.war /usr/local/tomcat/webapps
EXPOSE 8082
CMD ["/bin/sh"]
CMD ["/usr/local/tomcat/catalina.sh", "run"]
