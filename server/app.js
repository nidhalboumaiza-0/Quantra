const cors = require("cors");
const express = require("express");
const morgan = require("morgan");
const rateLimit = require("express-rate-limit");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
const xss = require("xss-clean");
const mongoSanitize = require("express-mongo-sanitize");
const helmet = require("helmet");
const app = express();
const bodyParser = require("body-parser");
const path = require("path");
const OneSignal = require("@onesignal/node-onesignal");
const cronTasks = require("./utils/cronTasks");
//------------ROUTES----------------
const userRouter = require("./routes/userRouter");
const authController = require("./controllers/authController");
//------------------------------
app.use(cors());
app.use(xss());
app.use(mongoSanitize());
app.use(helmet());
app.use(morgan("dev"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 1) MIDDLEWARES
const limiter = rateLimit({
  max: 100,
  windowMs: 60 * 60 * 1000,
  message:
    "Too many requests from this IP , please try again in an hour !",
});
app.use("/api", limiter);

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}
app.use(express.json());
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString();
  next();
});

// 2 ) Cron Tasks
cronTasks.sendNotification9();
// 3) ROUTES
app.use("/images", express.static(path.join(__dirname, "./images")));

app.use("/api/v1/users", userRouter);

//************************************************************** */
const configuration = OneSignal.createConfiguration({
  userAuthKey: "YjUwMzNjMjMtYzNhYy00OWVlLTg5ZjctYmYyYzljZGRlYTE5",
  restApiKey: "NjgxMDlkM2UtYmFjNC00ODUwLWI3M2QtNDU2ZjlkMTNiMGE4",
});

const client = new OneSignal.DefaultApi(configuration);

app.post(
  "/api/v1/send-notification",
  authController.protect,
  async (req, res) => {
    const { notificationHeader, notificationMessage } = req.body;

    // Create a new notification
    const notification = new OneSignal.Notification();
    notification.app_id = "c337b164-017f-48ed-9b27-a2c7d90dee46";
    notification.name = "test_notification_name";
    notification.contents = {
      en: notificationMessage,
    };
    notification.headings = {
      en: notificationHeader,
    };
    notification.included_segments = ["All"];
    notification.small_icon = "./images/default1.jpeg";
    notification.adm_big_picture = "./images/default1.jpeg";
    try {
      const notificationResponse =
        await client.createNotification(notification);
      res
        .status(200)
        .json({ success: true, response: notificationResponse });
    } catch (error) {
      res.status(500).json({ success: false, error: error.message });
    }
  }
);

//***************************************************************** */

app.all("*", (req, res, next) => {
  next(
    new AppError(`Can't find ${req.originalUrl} on this server!`, 404)
  );
});

app.use(globalErrorHandler);

module.exports = app;
