// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {setGroupClaims} from "./setGroupClaims";

export const authOnCreate = functions.auth.user().onCreate(async (context) => {
  try {
    await admin.auth().setCustomUserClaims(context.uid, {
      group_id: context.uid,
    });

    await setGroupClaims(context.uid, context.uid);

    console.log(`${context.uid} has been initialized with default group`);
    return {message:
      `Success! ${context.uid} has been initialized with group ${context.uid}.`,
    };
  } catch (err) {
    console.log(err);
    return err;
  }
});
