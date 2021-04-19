// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.addGroup = functions.https.onCall((data, context) => {
  // check request is made by a group member or new user 
  // TODO: move user creantion to on create
  // TODO: maybe switch case
  if (context.auth.token.guid === data.guid) {
    return { message: 'You are already in the group' }
  }
  if (context.auth.token.uid !== data.guid) {
    return { error: 'Only members of the group can add other members' }
  }

  // get user and add admin custom claim
  return admin.auth().getUser(context.auth.token.uid).then(user => {
    return admin.auth().setCustomUserClaims(user.uid, {
      group_id: data.guid
    })
  }).then(() => {
    return {
      message: `Success! ${context.auth.token.uid} has been added to the group ${data.guid}.`
    }
  }).catch(err => {
    return err;
  });
});

exports.authOnCreate = functions.auth.user().onCreate((context) => {
  return admin.auth().getUser(context.uid).then(user => {
    return admin.auth().setCustomUserClaims(user.uid, {
      group_id: user.uid
    })
  }).then(() => {
    return {
      message: `Success! ${context.uid} has been initialized with group ${context.uid}.`
    }
  }).catch(err => {
    return err;
  });
});
