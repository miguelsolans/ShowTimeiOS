//
//  GenericTableModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 22/10/2022.
//

import Foundation

class GenericTableModel : BaseModel {
    
    override init() {
        super.init();
        
        self.endpoints = [
            "getOne": "genericTable"
        ]
    }
    
    func getOne(tableName: String, completion: @escaping(_ output: GenericTableOutput) -> Void,
                     failure: @escaping(_ error: Error) -> Void) {
        
        var url = URLComponents(string: self.endpoints[ "getOne" ]!)!;
        url.queryItems = [URLQueryItem(name: "tableName", value: tableName)];
        
        let path = url.string!;
        
        self.networkManager.request(toURL: path, httpMethod: .get, parameters: nil) { (result: Result<GenericTableOutput, Error>) in
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error);
            }
        }
    }
}
