FROM openjdk:11
EXPOSE 8088
ADD target/timesheet-1.2.3-SNAPSHOT.jar timesheet-1.2.3-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/timesheet-1.2.3-SNAPSHOT.jar" ]