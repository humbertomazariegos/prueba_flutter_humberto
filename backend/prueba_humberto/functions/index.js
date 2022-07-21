// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp();


// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
// exports.addMessage = functions.https.onRequest(async (req, res) => {
//     // Grab the text parameter.
//     const original = req.query.text;
//     // Push the new message into Firestore using the Firebase Admin SDK.
//     const writeResult = await admin.firestore().collection('messages').add({original: original});
//     // Send back a message that we've successfully written the message
//     res.json({result: `Message with ID: ${writeResult.id} added.`});
// });

// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
// exports.makeUppercase = functions.firestore.document('/messages/{documentId}')
//     .onCreate((snap, context) => {
//     // Grab the current value of what was written to Firestore.
//     const original = snap.data().original;

//     // Access the parameter `{documentId}` with `context.params`
//     functions.logger.log('Uppercasing', context.params.documentId, original);

//     const uppercase = original.toUpperCase();

//     // You must return a Promise when performing asynchronous tasks inside a Functions such as
//     // writing to Firestore.
//     // Setting an 'uppercase' field in Firestore document returns a Promise.
//     return snap.ref.set({uppercase}, {merge: true});
// });

exports.sendMailByMailjet = functions.https.onRequest(async (req,res) =>{
    const Mailjet = require('node-mailjet');
    const mailjet = Mailjet.apiConnect(
        "cb8a096d7bc4b507345b49651e817fd2",
        "ddc2777bde8cf98a7371c8848f367d09",
    );

    const fromMail = req.query.fromMail;
    const fromName = req.query.fromName;
    const toMail = req.query.toMail;
    const toName = req.query.toName;
    const subject = req.query.subject;
    const textPart = req.query.textPart;
    const htmlPart = req.query.htmlPart;
    //http://localhost:5001/ingreso1-7fb4e/us-central1/sendMailByMailjet?fromMail=josehumberto.mazariegos@gmail.com&fromName=Humberto&toMail=josehumberto.mazariegos@gmail.com&toName=HumbertoDestino&subject=Asunto&textPart=Bienvenido a este espacio de mails&htmlPart=<h3>Dear passenger 1, welcome to <a href=\"https://www.mailjet.com/\">Mailjet</a>!</h3><br />May the delivery force be with you!
    const data = [fromMail,fromName,toMail,toName,subject,textPart,htmlPart];
    const request = mailjet
            .post('send', { version: 'v3.1' })
            .request({
            Messages: [
                {
                From: {
                    Email: data[0],
                    Name: data[1]
                },
                To: [
                    {
                    Email: data[2],
                    Name: data[3]
                    }
                ],
                Subject: data[4],
                TextPart: data[5],
                HTMLPart: data[6]
                }
            ]
            })
    request
        .then((result) => {
            console.log(result.body);
            res.json({result: result.body});
        })
        .catch((err) => {
            console.log(err.statusCode)
            res.json({error: err});
        })
});

exports.getAllUsers = functions.https.onRequest(async (req,res) => {
    var allUsers = [];
    return admin.auth().listUsers()
        .then(function (listUsersResult) {
            listUsersResult.users.forEach(function (userRecord) {
                // For each user
                var userData = userRecord.providerData[0];
                allUsers.push(userData);
            });
            res.status(200).send(JSON.stringify(allUsers));
        })
        .catch(function (error) {
            console.log("Error listing users:", error);
            res.status(500).send(error);
        });
});