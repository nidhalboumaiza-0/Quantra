const nodemailer = require("nodemailer");

const sendEmail = async (options) => {
  // 1) Create a transporter :
  var transport = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASSWORD,
    },
  });
  // 2) Define the email options :
  const mailOptions = {
    from: "Quantra <Quantra@gmail.tn>",
    to: options.email,
    subject: options.subject,
    text: options.message,
    attachments: options.attachments,
  };
  await transport.sendMail(mailOptions);
};

module.exports = sendEmail;
