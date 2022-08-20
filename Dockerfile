FROM tomcat:7.0
WORKDIR /assess2/DevOps-Assessment-2/
ADD ./*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
