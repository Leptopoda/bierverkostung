// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {firestore, messaging} from "firebase-admin";

/**
 * Sets group claim for the given user
 * @param {string} uid user ID
 * @param {messaging.MessagingPayload} payload notification data
 * @return {Promise<messaging.MessagingDevicesResponse>}
 */
export async function notifyUser(
    uid: string, payload : messaging.MessagingPayload):
Promise<void> {
  const querySnapshot = await firestore()
      .collection("users")
      .doc(uid)
      .collection("notification-token")
      .get();

  const tokens = querySnapshot.docs.map((doc) => doc.data()["token"]);

  try {
    const response = await messaging().sendToDevice(tokens, payload);
    console.log("Successfully sent message:", response);
  } catch (error) {
    console.log("Error sending message:", error);
  }
}

/**
 * Sets group claim for the given user
 * @param {string} topic topic to send to
 * @param {messaging.MessagingPayload} payload notification data
 * @return {Promise<messaging.MessagingTopicResponse>}
 */
export async function notifyTopic(
    topic: string, payload : messaging.MessagingPayload):
Promise<messaging.MessagingTopicResponse> {
  return messaging().sendToTopic(topic, payload);
}
