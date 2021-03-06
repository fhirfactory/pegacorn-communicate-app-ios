// 
// Copyright 2020 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

class Role: Equatable {
    static func == (lhs: Role, rhs: Role) -> Bool {
        lhs.Identifier == rhs.Identifier && lhs.Name == rhs.Name
    }
    
    let Name: String
    let Title: String
    let Identifier: String
    let OfficialName: String
    
    //Category, Org Unit, Location and Designation should in reality not be strings but instead links to other objects
    let Designation: String
    
    let Location: String
    //is "Category" actually "Specialty"?
    let Category: String
    let OrgUnit: String
    
    convenience init(withName name: String, andId id: String, andDescription description: String) {
        //  a location string should come about by looking up the location, and then generating the abbreviated string.
        //  Location = "CH {Canberra Hospital}"
        //  Category = "Emergency"
        //  OrgUnit = "ED {Emergency Department}"
        self.init(name: name, longname: name, id: id, description: description, designation: name, category: "Emergency", location: "CH {Canberra Hospital}", orgunit: "ED {Emergency Department}")
    }
    convenience init(withName name: String, andId id: String, andDescription description: String, andDesignation designation: String) {
        //  a location string should come about by looking up the location, and then generating the abbreviated string.
        //  Location = "CH {Canberra Hospital}"
        //  Category = "Emergency"
        //  OrgUnit = "ED {Emergency Department}"
            self.init(name: name, longname: name, id: id, description: description, designation: designation, category: "Emergency", location: "CH {Canberra Hospital}", orgunit: "ED {Emergency Department}")
    }
    convenience init(withName name: String, andId id: String, andDescription description: String, andDesignation designation: String, andLocation location: String) {
        //  a location string should come about by looking up the location, and then generating the abbreviated string.
        //  Location = location
        //  Category = "Emergency"
        //  OrgUnit = "ED {Emergency Department}"
        self.init(name: name, longname: name, id: id, description: description, designation: designation, category: "Emergency", location: location, orgunit: "ED {Emergency Department}")
    }
    init(name: String, longname: String, id: String, description: String, designation: String, category: String, location: String, orgunit: String) {
        Name = name
        Title = longname
        Identifier = id
        OfficialName = description
        Designation = designation
        Category = category
        Location = location
        OrgUnit = orgunit
    }
    func getRoleModel() -> RoleModel {
        return RoleModel(innerRole: self, isExpanded: false)
    }
}
