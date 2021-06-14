// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {region} from "firebase-functions";
import {firestore} from "firebase-admin";
import {dataCenter} from "./comon";

export const moneyCalc = region(dataCenter)
    .firestore
    .document("/groups/{groupID}/money/{moneyID}")
    .onWrite(async (change, context) => {
      try {
        const db = firestore();
        const data = change.after.data();
        if ( data == undefined || data["amount"] == null ||
        data["buyer"] == null || data["timestamp"] == null) {
          throw new Error("invalid data");
        }
        const groupRef = firestore().collection("groups")
            .doc(context.params.groupID)
            .collection("group-info")
            .doc(context.params.groupID);
        const groupData = await groupRef.get();

        const buyer: string = data["buyer"];
        const members : [string] = groupData.get("members");
        let increment : firestore.FieldValue;
        members.forEach(async (member: string) => {
          if (buyer == member ) {
            increment = firestore.FieldValue.increment(
                -data["amount"] + (data["amount"] / members.length));
          } else {
            increment = firestore.FieldValue.increment(
                data["amount"] / members.length);
          }
          const calcRef = db.collection("groups")
              .doc(context.params.groupID)
              .collection("money-computed")
              .doc(member);

          await calcRef.set({
            buyer: buyer,
            amount: increment,
            timestamp: data["timestamp"],
          }, {merge: true});
        });


        console.log("calculated money");
      } catch (error) {
        console.log(error);
      }
    });
