package ca.jrvs.apps.grep;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


public class JavaGrepLambdaImp extends JavaGrepImp{

    public static void main(String [] args) {
        if (args.length != 3) {
            throw new IllegalArgumentException("USAGE: JavaGrep regex rootDir outfile");
        }

        //creating JavaGrepLambdaImp instead of JavaGrepImp
        //JavaGrepLambdaImp inherits all methods except two override methods in JavaGrepImp
        JavaGrepLambdaImp javaGrepLambdaImp = new JavaGrepLambdaImp();
        javaGrepLambdaImp.setRegex(args[0]);
        javaGrepLambdaImp.setRootPath(args[1]);
        javaGrepLambdaImp.setOutFile(args[2]);

        try {
            //calling parent method
            //but it will call override method (in this class)
            javaGrepLambdaImp.process();
        }catch (Exception ex) {
            javaGrepLambdaImp.logger.error("Failed to start the process", ex);
        }
    }

    //implement using lambda and stream APIs
    // Reads lines from a given file
    @Override
    public List<String> readLines(File inputFile) {
        // Check if file is a regular file, throw an exception if not
        if (!inputFile.isFile()) {
            throw new IllegalArgumentException("Error: Provided input file is not a regular file");
        }

        // Initialize list to store lines read from file
        List<String> lines = new ArrayList<>();
        try {
            // Read lines from file and store them in the 'lines' list
            lines = Files.readAllLines(inputFile.toPath());
        } catch (Exception ex) {
            // Log error message if there's an exception while reading lines from file
            logger.error("Error: Failed to read lines from file", ex);
        }
        // Return the list of lines read from the file
        return lines;
    }

    //implement using lambda and stream APIs
    // Lists all regular files in the specified directory and its subdirectories
    @Override
    public List<File> listFiles(String rootDir) {
        // Initialize a list to store the identified regular files
        List<File> files = new ArrayList<>();
        try (Stream<Path> fileStream = Files.walk(Paths.get(rootDir))) {

            // Filter the stream to include only regular files, then map the paths to files, and collect them into a list
            files = fileStream
                    .filter(Files::isRegularFile)
                    .map(Path::toFile)
                    .collect(Collectors.toList());
        } catch (Exception ex) {
            // Log an error message if there's an exception while listing files
            logger.error("Error: Failed to list files", ex);
        }

        // Return the list of identified regular files
        return files;
    }
}