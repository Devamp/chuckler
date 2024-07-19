const {getFirestore} = require("firebase-admin/firestore");
// eslint-disable-next-line no-unused-vars
const {onDocumentCreated, Change} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
initializeApp();
const db = getFirestore();


// createMatchups runs every time a new post occurs
// creates matchup with unmatched post
// and if no match exists sets the matched key to false.

exports.createMatchup = onDocumentCreated("Posts/{docid}", async (event) => {
  const eData = event.data.data();
  try {
    // Find a post that does not have a match up
    const matchingPost = await db.collection("Posts")
        .where("promptId", "==", eData.promptId)
        .where("promptDateId", "==", eData.promptDateId)
        .where("matched", "==", false)
        .orderBy("date", "asc")
        .limit(1).get();
    // Check if a match up was found
    if (matchingPost == null || matchingPost.empty) {
      // eslint-disable-next-line max-len
      await db.collection("Posts").doc(event.data.id).update({"matched": false});
    } else {
      // Create the match up and set the found posts matched flag to true
      await matchingPost.docs[0].ref.update(
          {"matched": true},
      );
      const mPD = matchingPost.docs[0].data();
      await db.collection("MatchUps").doc().set({
        answer1: eData.answer,
        uid1: eData.uid,
        postId1: event.data.id,
        username1: eData.username,
        wins1: 0,
        answer2: mPD.answer,
        uid2: mPD.uid,
        username2: mPD.username,
        postId2: matchingPost.docs[0].id,
        wins2: 0,
        views: 0,
        promptId: eData.promptId,
        promptDateId: mPD.promptDateId,
      });
    }
  } catch (e) {
    console.log(e);
  }
});
