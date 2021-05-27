// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {region} from "firebase-functions";
import {auth, messaging} from "firebase-admin";
import {setGroupClaims} from "./setGroupClaims";
import {notifyUser} from "./notification";
import {dataCenter} from "./comon";


export const addGroup = region(dataCenter)
    .https.onCall(async (data, context) => {
      // check request is made by a group member or new user
      if (context?.auth?.token["group_ID"] !== data.guid &&
          context?.auth?.token["user_id"] !== data.guid) {
        console.log(`${context?.auth?.token["user_id"]} 
        insufficient permission`);
        return {error: "Only members of the group can add other members"};
      }

      // get user and add admin custom claim
      try {
        const user = await auth().getUser(data.uid);

        if (user.customClaims?.["group_id"] == data.guid) {
          return {message: "User is already in the group"};
        }

        await setGroupClaims(user.uid, data.guid);

        const payload: messaging.MessagingPayload = {
          notification: {
            title: "New Group!",
            body: `you have been added to the group ${data.guid}`,
            // icon: "your-icon-url",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            auth_refresh: "true",
          },
        };
        await notifyUser(user.uid, payload);

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
