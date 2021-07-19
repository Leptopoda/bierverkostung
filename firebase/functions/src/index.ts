// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import {initializeApp} from "firebase-admin";
initializeApp();

export {authOnCreate} from "./groupManagement/authOnCreate";
export {addGroup} from "./groupManagement/addGroup";
export {removeGroup} from "./groupManagement/removeFromGroup";
export {beerStats} from "./statCounter";
// export {exportData, clearData} from "./gdprData/index";
export {moneyCalc} from "./moneyCalc";
