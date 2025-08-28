public class RunBash {
    public static void main(String[] args) {
        try {
            // Chỉ chạy bash, không nhận tham số
            Process process = new ProcessBuilder("bash")
                    .inheritIO()
                    .start();

            process.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
