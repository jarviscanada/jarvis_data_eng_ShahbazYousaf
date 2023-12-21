# Introduction
Created a Java grep app that mimics Linux grep command which allows users to search matching strings from files. This application recursively searches a root directory for a provided regex pattern, identifies matching lines, and saves them to an output file specified by the user. With a designated input root directory, regex pattern, and output file, the app systematically traverses every file within the root, outputting lines that match the specified pattern into the provided file. The application is packaged with Docker, allowing users to pull the image from DockerHub for implementation. Technologies used for this application include Java, Maven, Intellij, Lambda & Stream API, and Docker.

#Quick Start
## Build and compile the maven project and package the program into a JAR file
mvn clean compile project

#Run the JAR file with the three arguments [regex], [rootDirectory], [outputFile] to perform the grep search
java -cp target/grep-1.0-SNAPSHOT.jar ca.jrvs.apps.grep.JavaGrepImp [regex] [rootDirectory] [outputFile]

#View the output file containing the matched lines
cat [outputFile]


#Implemenation
## Pseudocode
The Java Grep application uses a process method to effectively orchestrate the entire procedure, mirroring the functionality of the Linux grep command in Java. The pseudocode is as follows:

matchedLines[]
for file in listFilesRecursively(rootDir)
    for line in readFile(file)
        if containsPattern(line)
            matchedLines.add(line)
writeToFile(matchedLines)


## Performance Issue
When dealing with large files in the root directory, both implementations of the Java Grep application may encounter performance issues, potentially leading to challenges due to memory limitations. However, the JavaGrepLambdaImp class addresses this by utilizing Java Stream and Lambda functionalities,  ensuring a more efficient approach to line processing without the risk of memory-related problems.

# Test
The project was tested manually to verify the functionality of both implementations of the Java Grep application. 

# Deployment
The Java Grep application was dockerized as a Docker Image and uploaded to DockerHub for convenient access and utilization. To obtain the Docker image and utilize the application, follow the steps below:
# Pull the image from DockerHub
docker/pull shahbvz/grep

# Run the docker container
docker run --rm -v `pwd` /data:/data -v `pwd` /log:/log shahbvz/grep .[regex] /data /log/tmp.out

# Improvement
Improve file reading to handle larger files without needing JVM memory adjustments
Integrate additional Linux grep functionalities, such as case-insensitive searching
Display the file name and line number where the matching regex pattern is found
