public class run {
    public static void main(String[] args) {
        try {
            String command = "bash start.sh";

            Process process = new ProcessBuilder("bash", "-c", command)
                    .inheritIO()
                    .start();

            process.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
