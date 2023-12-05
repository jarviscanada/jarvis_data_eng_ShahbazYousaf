package ca.jrvs.apps.practice;

public interface RegexExc {
    /**
     * return true if filename extension is jpg or jpeg (case insensitive)
     * @param filename
     * @return
     */
    public boolean matchJpeg(String filename);
    /**
     * return true if ip is valid
     * to simplify the problem, IP address rang is from 0.0.0.0 to 999.999.999.999
     * @Param ip
     * @return
     */

    public boolean matchIP(String ip);

    /**
     * return true if line is empty (e.g. empty white space, tabs, etc...)
     * @param line
     * return
     */
    public boolean isEmptyLine(String line);
}