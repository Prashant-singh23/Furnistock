package com.Furnistock.util;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 465;
    private static final String SMTP_USERNAME = getSetting("GMAIL_USER", "gmail.user");
    private static final String SMTP_PASSWORD = getSetting("GMAIL_APP_PASSWORD", "gmail.app.password");

    public static boolean sendEmail(String toAddress, String subject, String body) {
        if (SMTP_USERNAME == null || SMTP_USERNAME.isBlank() || SMTP_PASSWORD == null || SMTP_PASSWORD.isBlank()) {
            System.err.println("EmailUtil: Gmail credentials are not configured. Set GMAIL_USER/GMAIL_APP_PASSWORD or java properties gmail.user/gmail.app.password.");
            return false;
        }

        try (SSLSocket socket = (SSLSocket) SSLSocketFactory.getDefault().createSocket(SMTP_HOST, SMTP_PORT);
             BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8));
             BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8))) {

            readResponse(reader);
            sendCommand(writer, reader, "EHLO localhost", 250);
            sendCommand(writer, reader, "AUTH LOGIN", 334);
            sendCommand(writer, reader, encodeBase64(SMTP_USERNAME), 334);
            sendCommand(writer, reader, encodeBase64(SMTP_PASSWORD), 235);
            sendCommand(writer, reader, "MAIL FROM:<" + SMTP_USERNAME + ">", 250);
            sendCommand(writer, reader, "RCPT TO:<" + toAddress + ">", 250, 251);
            sendCommand(writer, reader, "DATA", 354);
            writer.write("From: " + SMTP_USERNAME + "\r\n");
            writer.write("To: " + toAddress + "\r\n");
            writer.write("Subject: " + subject + "\r\n");
            writer.write("Content-Type: text/plain; charset=UTF-8\r\n");
            writer.write("\r\n");
            writer.write(body.replace("\r\n", "\n").replace("\n", "\r\n"));
            writer.write("\r\n.\r\n");
            writer.flush();
            readResponse(reader);
            sendCommand(writer, reader, "QUIT", 221);
            return true;

        } catch (IOException e) {
            System.err.println("EmailUtil error sending to " + toAddress + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private static void sendCommand(BufferedWriter writer, BufferedReader reader, String command, int... expectedCodes)
            throws IOException {
        writer.write(command + "\r\n");
        writer.flush();
        String response = readResponse(reader);
        if (expectedCodes.length > 0) {
            boolean matched = false;
            for (int code : expectedCodes) {
                if (response.startsWith(String.valueOf(code))) {
                    matched = true;
                    break;
                }
            }
            if (!matched) {
                throw new IOException("SMTP unexpected response: " + response + " for command: " + command);
            }
        }
    }

    private static String readResponse(BufferedReader reader) throws IOException {
        StringBuilder response = new StringBuilder();
        String line = reader.readLine();
        if (line == null) {
            throw new IOException("SMTP connection closed unexpectedly");
        }
        response.append(line);
        while (line.length() >= 4 && line.charAt(3) == '-') {
            line = reader.readLine();
            if (line == null) {
                break;
            }
            response.append("\n").append(line);
        }
        return response.toString();
    }

    private static String encodeBase64(String text) {
        return Base64.getEncoder().encodeToString(text.getBytes(StandardCharsets.UTF_8));
    }

    private static String getSetting(String envKey, String propKey) {
        String value = System.getenv(envKey);
        if (value != null && !value.isBlank()) {
            return value;
        }
        value = System.getProperty(propKey);
        return value != null && !value.isBlank() ? value : null;
    }

    public static boolean isConfigured() {
        return SMTP_USERNAME != null && !SMTP_USERNAME.isBlank()
                && SMTP_PASSWORD != null && !SMTP_PASSWORD.isBlank();
    }
}
