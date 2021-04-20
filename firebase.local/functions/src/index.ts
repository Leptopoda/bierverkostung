// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

exports.addGroup = functions.https.onCall(async (data, context) => {
  // check request is made by a group member or new user
  if (context?.auth?.token.group_id !== data.guid &&
  context?.auth?.token.user_id !== data.guid) {
    console.log(`${context?.auth?.token.user_id} insufficient permission`);
    return {error: "Only members of the group can add other members"};
  }

  // get user and add admin custom claim
  try {
    var user = await admin.auth().getUser(data.uid);

    if (user.customClaims!['group_id'] === data.guid){
      return {message: "User is already in the group"};
    }

    await admin.auth().setCustomUserClaims(user.uid, {
      group_id: data.guid,
    });

    console.log(`${user.uid}
    has been added to the group ${data.guid} 
    by ${context?.auth?.token.uid}`);

    return {message:
      `Success! ${user.uid}
      has been added to the group ${data.guid}.`,
    };
  } catch (err) {
    console.log(err);
    return err;
  }
});

exports.authOnCreate = functions.auth.user().onCreate(async (context) => {

  try {
    await admin.auth().setCustomUserClaims(context.uid, {
      group_id: context.uid,
    });

    console.log(`${context.uid} has been initialized with default group`);
    return {message:
      `Success! ${context.uid} has been initialized with group ${context.uid}.`,
    };
  } catch (err) {
    console.log(err);
    return err;
  }

  return admin.auth().setCustomUserClaims(context.uid, {
    group_id: context.uid,
  }).then(() => {
    
  }).catch((err) => {

  });
});
