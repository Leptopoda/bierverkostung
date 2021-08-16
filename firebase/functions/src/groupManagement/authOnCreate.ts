// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {region} from "firebase-functions";
import {auth} from "firebase-admin";
import {setGroupClaims} from "./setGroupClaims";
import {dataCenter} from "../comon";
import {addGroupUpdate} from "./updateGroupData";
import {userGroupUpdate} from "./updateUserData";

export const authOnCreate = region(dataCenter).
    auth.user().onCreate(async (context) => {
      try {
        await auth().setCustomUserClaims(context.uid, {
          group_id: context.uid,
        });

        await setGroupClaims(context.uid, context.uid);
        await addGroupUpdate(context.uid, context.uid);
        await userGroupUpdate(context.uid, context.uid);

        console.log(`${context.uid} has been initialized with default group`);
        return {message:
      `Success! ${context.uid} has been initialized with group ${context.uid}.`,
        };
      } catch (err) {
        console.log(err);
        return err;
      }
    });
