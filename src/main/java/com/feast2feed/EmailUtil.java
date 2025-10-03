package com.feast2feed;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

/**
 * Utility class to send emails using Jakarta Mail API.
 */
public class EmailUtil {
    // Sender's email address and Gmail App Password
    private static final String FROM_EMAIL = "tmsharks.sla@gmail.com";
    private static final String FROM_PASSWORD = "aeeleighlhjacuio"; // ✅ correct Gmail App Password

    /**
     * Sends a thank-you email to the donor when their food donation has been delivered.
     *
     * @param toEmail          The recipient's email address (donor email).
     * @param donorName        The name of the donor.
     * @param orphanageName    The name of the orphanage that received the donation.
     * @param orphanageAddress The address of the orphanage.
     * @throws MessagingException            If sending the email fails.
     * @throws UnsupportedEncodingException  If the encoding specified in the sender's name is not supported.
     */
    public static void sendThankYouEmail(
            String toEmail,
            String donorName,
            String orphanageName,
            String orphanageAddress)
            throws MessagingException, UnsupportedEncodingException {

        // ✅ SMTP configuration for Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // enable TLS

        // ✅ Create authenticated session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });

        // ✅ Build the email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL, "Feast2Feed"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Thank You for Your Food Donation!");

        // ✅ Enhanced HTML Content
        String content = String.format(
                "<html>" +
                "<body style='font-family:Arial,sans-serif; line-height:1.6;'>" +
                "<h2 style='color:#2E86C1;'>Dear %s,</h2>" +
                "<p>Thank you so much for your generous food donation! 🙏</p>" +
                "<p>Your kindness has made a real difference. We're happy to share that your donation was successfully delivered to:</p>" +
                "<p><b>%s</b><br>%s</p>" +
                "<p>Because of your support, children and residents at the orphanage can enjoy a healthy meal and feel the warmth of your compassion.</p>" +
                "<p style='margin-top:20px;'>Together, we can spread smiles and hope. 💙</p>" +
                "<hr>" +
                "<p style='font-size:12px; color:#555;'>With gratitude,<br><b>Feast2Feed Team</b></p>" +
                "</body>" +
                "</html>",
                donorName != null ? donorName : "Donor",
                orphanageName != null ? orphanageName : "the orphanage",
                orphanageAddress != null ? orphanageAddress : "the address"
        );

        // ✅ Set HTML content instead of plain text
        message.setContent(content, "text/html; charset=UTF-8");

        // ✅ Send email
        Transport.send(message);
    }

    /**
     * Sends a cancellation email to the donor when delivery to orphanage is cancelled
     * and food is distributed to street underprivileged people.
     *
     * @param toEmail   The recipient's email address (donor email).
     * @param donorName The name of the donor.
     * @param foodType  The type of food that was donated.
     * @throws MessagingException           If sending the email fails.
     * @throws UnsupportedEncodingException If the encoding specified in the sender's name is not supported.
     */
    public static void sendCancellationEmail(
            String toEmail,
            String donorName,
            String foodType)
            throws MessagingException, UnsupportedEncodingException {

        // SMTP configuration for Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Create authenticated session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });

        // Build the email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL, "Feast2Feed"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Update on Your Food Donation Delivery");

        // HTML Content for cancellation
        String content = String.format(
                "<html>" +
                "<body style='font-family:Arial,sans-serif; line-height:1.6;'>" +
                "<h2 style='color:#2E86C1;'>Dear %s,</h2>" +
                "<p>We sincerely appreciate your generous food donation (<b>%s</b>).</p>" +
                "<p>Due to unforeseen circumstances, we were unable to complete the delivery to the originally planned orphanage. However, your kindness has still made a profound impact.</p>" +
                "<div style='background-color: #fff3cd; padding: 15px; border-radius: 5px; border-left: 4px solid #ffc107; margin: 15px 0;'>" +
                "<p style='margin:0; color: #856404;'><strong>✨ Your food was respectfully redirected and distributed to underprivileged individuals in need within our community.</strong></p>" +
                "</div>" +
                "<p>Your generosity has provided nourishment and comfort to some of the most vulnerable members of society, bringing hope where it is needed most.</p>" +
                "<p>Thank you for your compassion, understanding, and continued support in our mission to fight hunger.</p>" +
                "<hr>" +
                "<p style='font-size:12px; color:#555;'>With heartfelt gratitude,<br><b>Feast2Feed Team</b></p>" +
                "</body>" +
                "</html>",
                donorName != null ? donorName : "Donor",
                foodType != null ? foodType : "food donation"
        );

        message.setContent(content, "text/html; charset=UTF-8");
        Transport.send(message);
    }
}