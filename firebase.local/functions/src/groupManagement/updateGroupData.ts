// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {firestore} from "firebase-admin";

/**
 * Updates group metadata when adding a new user
 * @param {string} uid user ID
 * @param {string} guid group ID
 * @return {Promise<void>}
 */
export async function addGroupUpdate(uid: string, guid: string):Promise<void> {
  const members = firestore.FieldValue.arrayUnion(uid);
  const memberCount = firestore.FieldValue.increment(1);
  const groupRef = firestore().collection("groups")
      .doc(guid)
      .collection("group-info")
      .doc(guid);

  await groupRef.set({
    members: members,
    count: memberCount,
  }, {merge: true});
  return;
}

/**
 * Updates group metadata when removing a user
 * @param {string} uid user ID
 * @param {string} guid group ID
 * @return {Promise<void>}
 */
export async function removeGroupUpdate(uid: string, guid: string):
Promise<void> {
  const members = firestore.FieldValue.arrayRemove(uid);
  const memberCount = firestore.FieldValue.increment(-1);
  const groupRef = firestore().collection("groups")
      .doc(guid)
      .collection("group-info")
      .doc(guid);

  await groupRef.set({
    members: members,
    count: memberCount,
  }, {merge: true});
  return;
}
