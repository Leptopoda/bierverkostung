// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {auth} from "firebase-admin";

/**
 * Sets group claim for the given user
 * @param {string} uid user ID
 * @param {string} guid group ID
 * @return {Promise<void>}
 */
export async function setGroupClaims(uid: string, guid: string):Promise<void> {
  return await auth().setCustomUserClaims(uid, {
    group_id: guid,
  });
}
