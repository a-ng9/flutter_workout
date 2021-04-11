const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp;
const database = admin.firestore;

exports.sendNotification = functions.https.onCall((data, context) => {
  try {
    const payload = {
      notification: {
        title: "The title of the notification",
        body: data["your_param_sent_from_the_client"], //Or you can set a server value here.
      },
      //If you want to send additional data with the message,
      //which you dont want to show in the notification itself.
      data: {
        data_to_send: "msg_from_the_cloud",
      },
    };
    admin
      .messaging()
      .sendToTopic("AllPushNotifications", payload)
      .then((value) => {
        console.info("function executed succesfully");
        return { msg: "function executed succesfully" };
      })
      .catch((error) => {
        console.info("error in execution");
        console.log(error);
        return new { msg: "error in execution" };
      });
  } catch (error) {
      throw new functions.https.HttpsError('invalid-argument', 'some message');
  }
});
