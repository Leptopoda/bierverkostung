// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {initializeApp} from "firebase-admin";
initializeApp();

export {authOnCreate} from "./authOnCreate";
export {addGroup} from "./addGroup";
export {beerStats} from "./statCounter";
export {exportData, clearData} from "./gdprData/index";
