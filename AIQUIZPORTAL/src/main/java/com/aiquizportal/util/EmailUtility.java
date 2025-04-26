package com.aiquizportal.util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtility {

  private static final String SMTP_USER = System.getenv("SMTP_USER");
  private static final String SMTP_PASS = System.getenv("SMTP_PASS");

  public static void sendEmail(String to, String subject, String body)
          throws MessagingException {

      if (to == null || to.trim().isEmpty()) {
          throw new IllegalArgumentException("Recipient email cannot be null or empty");
      }

      Properties props = new Properties();
      props.put("mail.smtp.host", "smtp.gmail.com");
      props.put("mail.smtp.port", "587");
      props.put("mail.smtp.auth", "true");
      props.put("mail.smtp.starttls.enable", "true");

      Session session = Session.getInstance(props, new Authenticator() {
          @Override
          protected PasswordAuthentication getPasswordAuthentication() {
              return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
          }
      });

      Message msg = new MimeMessage(session);
      msg.setFrom(new InternetAddress(SMTP_USER));
      msg.setRecipients(
          Message.RecipientType.TO,
          InternetAddress.parse(to)
      );
      msg.setSubject(subject);
      msg.setText(body);

      Transport.send(msg);
  }
}
