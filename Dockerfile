FROM tomcat:7.0
WORKDIR /assess2/DevOps-Assessment-2/
COPY ./*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["cataliona.sh", "run"]
