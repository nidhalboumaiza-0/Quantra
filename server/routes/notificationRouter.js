const OneSignal = require("@onesignal/node-onesignal");
// Create OneSignal configuration
const configuration = OneSignal.createConfiguration({
  authMethods: {
    app_key: {
      tokenProvider: {
        getToken: () =>
          "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
      },
    },
  },
});

// Create OneSignal client
const client = new OneSignal.DefaultApi(configuration);

app.post("/send-notification", async (req, res) => {
  const { message } = req.body;

  // Create a new notification
  const notification = new OneSignal.Notification();
  notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
  notification.contents = {
    en: message,
  };
  notification.headings = {
    en: "Gig'em Ags",
  };
  notification.included_segments = ["All"];

  try {
    const notificationResponse =
      await client.createNotification(notification);
    res
      .status(200)
      .json({ success: true, response: notificationResponse });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});
