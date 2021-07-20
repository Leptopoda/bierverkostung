// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {region} from "firebase-functions";
import {auth, messaging} from "firebase-admin";
import {setGroupClaims} from "./setGroupClaims";
import {notifyUser} from "../notification";
import {dataCenter} from "../comon";
import {addGroupUpdate, removeGroupUpdate} from "./updateGroupData";


export const removeGroup = region(dataCenter)
    .https.onCall(async (data, context) => {
      // get user and add admin custom claim
      try {
        const user = await auth().getUser(data.uid);

        // check request is made by a group member or new user
        if (context?.auth?.token["group_id"] !== user
            .customClaims?.["group_id"] &&
            context?.auth?.token["user_id"] !== user
                .customClaims?.["group_id"]) {
          console.log(`${context?.auth?.token["user_id"]} 
          insufficient permission`);
          return {error: "Only members of the group can remove other members"};
        }

        await removeGroupUpdate(user.uid, user.customClaims?.["group_id"]);
        await setGroupClaims(user.uid, user.uid);
        await addGroupUpdate(user.uid, user.uid);

        const payload: messaging.MessagingPayload = {
          notification: {
            title: "New Group!",
            body: `you have been added to the group ${user.uid}`,
            // icon: "your-icon-url",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            auth_refresh: "true",
          },
        };
        await notifyUser(user.uid, payload);

        console.log(`${user.uid}
        has been removed from their group 
        by ${context?.auth?.token["user_id"]}`);

        return {
          message: `Success! ${user.uid} has been removedfrom the group.`};
      } catch (err) {
        console.log(err);
        return {message: err};
      }
    });
