// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {firestore} from "firebase-admin";

/**
 * Updates user metadata when changing their group
 * @param {string} uid user ID
 * @param {string} guid group ID
 * @return {Promise<void>}
 */
export async function userGroupUpdate(uid: string, guid: string):Promise<void> {
  const userRef = firestore().collection("users")
      .doc(uid)
      .collection("user_data")
      .doc(uid);

  await userRef.set({
    guid: guid,
  }, {merge: true});
  return;
}
