// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import * as functions from "firebase-functions";
import {firestore} from "firebase-admin";
import {dataCenter} from "./comon";

// Listen for updates to any `user` document.
/* export const countNameChanges = functions.firestore
    .document("/users/{userID}/stats/{statsID}")
    .onUpdate((change, context) => {
      // Retrieve the current and previous value
      const data = change.after.data();
      const previousData = change.before.data();

      // We'll only update if the name has changed.
      // This is crucial to prevent infinite loops.
      if (data.name == previousData.name) {
        return null;
      }

      // Retrieve the current count of name changes
      let count = data.name_change_count;
      if (!count) {
        count = 0;
      }

      // Then return a promise of a set operation to update the count
      return change.after.ref.set({
        name_change_count: count + 1
      }, {merge: true});
    }); */

export const beerStats = functions.region(dataCenter)
    .firestore
    .document("/users/{userID}/stats/{statsID}")
    .onWrite(async (change, context) => {
      try {
        const db = firestore();
        const increment = firestore.FieldValue.increment(1);
        const data = change.after.data();
        const beer: string = ( data != undefined && data["beer"] != null)?
          data["beer"] : "undefined";

        const statsRef = db.collection("users")
            .doc(context.params.userID)
            .collection("stats-computed")
            .doc(beer);

        await statsRef.set({
          beerName: beer,
          beerCount: increment,
        }, {merge: true});
        console.log("incremented value");
      } catch (error) {
        console.log(error);
      }
    });
