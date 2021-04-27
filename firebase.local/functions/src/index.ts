// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {authOnCreate} from "./authOnCreate";
import {addGroup} from "./addGroup";

import * as admin from "firebase-admin";
admin.initializeApp();

exports.addGroup = addGroup;

exports.authOnCreate = authOnCreate;
