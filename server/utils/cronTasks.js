const cron = require("node-cron");
const mongoose = require("mongoose");
const OneSignal = require("@onesignal/node-onesignal");

exports.sendNotification9 = () => {
  cron.schedule("0 21 * * *", async function () {
    console.log("Running cron job to update product statuses");
    const configuration = OneSignal.createConfiguration({
      userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
      restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
    });

    const client = new OneSignal.DefaultApi(configuration);

    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "Quantra";
    notification.contents = {
      en: "Le pont va s'élever aprés une heure",
    };
    notification.headings = {
      en: "Attention",
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg"; // Set the image URL here
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
};

exports.sendNotification945 = () => {
  cron.schedule("45 21 * * *", async function () {
    console.log("Running cron job to update product statuses");
    const configuration = OneSignal.createConfiguration({
      userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
      restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
    });

    const client = new OneSignal.DefaultApi(configuration);

    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "Quantra";
    notification.contents = {
      en: "Le pont va s'élever aprés 15 minutes",
    };
    notification.headings = {
      en: "Attention",
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg"; // Set the image URL here
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
};

exports.sendNotification1030 = () => {
  cron.schedule("30 22 * * *", async function () {
    console.log("Running cron job to update product statuses");
    const configuration = OneSignal.createConfiguration({
      userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
      restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
    });

    const client = new OneSignal.DefaultApi(configuration);

    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "Quantra";
    notification.contents = {
      en: "Le pont est dans un état normal et vous peuvez avancer",
    };
    notification.headings = {
      en: "Attention",
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg"; // Set the image URL here
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
};

exports.sendNotification3 = () => {
  cron.schedule("* 03 * * *", async function () {
    console.log("Running cron job to update product statuses");
    const configuration = OneSignal.createConfiguration({
      userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
      restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
    });

    const client = new OneSignal.DefaultApi(configuration);

    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "Quantra";
    notification.contents = {
      en: "Le pont va s'élever aprés une heure",
    };
    notification.headings = {
      en: "notificationHeader",
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg"; // Set the image URL here
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
};

exports.sendNotification345 = () => {
  cron.schedule("45 03 * * *", async function () {
    console.log("Running cron job to update product statuses");
    const configuration = OneSignal.createConfiguration({
      userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
      restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
    });

    const client = new OneSignal.DefaultApi(configuration);

    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "Quantra";
    notification.contents = {
      en: "Le pont va s'élever aprés 15 minutes",
    };
    notification.headings = {
      en: "Attention",
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg"; // Set the image URL here
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
};

exports.sendNotification430 = () => {
  cron.schedule("30 04 * * *", async function () {
    console.log("Running cron job to update product statuses");
    const configuration = OneSignal.createConfiguration({
      userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
      restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
    });

    const client = new OneSignal.DefaultApi(configuration);

    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "Quantra";
    notification.contents = {
      en: "Le pont est dans un état normal et vous peuvez avancer",
    };
    notification.headings = {
      en: "Attention",
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg"; // Set the image URL here
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
};
