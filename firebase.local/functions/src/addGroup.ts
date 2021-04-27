// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const addGroup = functions.https.onCall(async (data, context) => {
  // check request is made by a group member or new user
  if (context?.auth?.token["group_ID"] !== data.guid &&
  context?.auth?.token["user_id"] !== data.guid) {
    console.log(`${context?.auth?.token["user_id"]} insufficient permission`);
    return {error: "Only members of the group can add other members"};
  }

  // get user and add admin custom claim
  try {
    const user = await admin.auth().getUser(data.uid);

    if (user.customClaims?["group_id"] : undefined === data.guid) {
      return {message: "User is already in the group"};
    }

    await admin.auth().setCustomUserClaims(user.uid, {
      group_ID: data.guid,
    });

    console.log(`${user.uid}
    has been added to the group ${data.guid} 
    by ${context?.auth?.token["user_id"]}`);

    return {message:
      `Success! ${user.uid}
      has been added to the group ${data.guid}.`,
    };
  } catch (err) {
    console.log(err);
    return err;
  }
});

export {addGroup};
