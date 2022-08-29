//
//  FirebaseTool.swift
//  GilCat
//
//  Created by 김동락 on 2022/08/29.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseTool {
    static let instance = FirebaseTool()
    private let storagePath = Firestore.firestore()
    
    func uploadCat(newCat: GilCatInfo, completion: @escaping ((Error?) -> Void)) {
        let storageRef = storagePath.collection("GilCatInfo")
        let dictionary = newCat.dictionary
        storageRef.addDocument(data: dictionary) { error in
            completion(error)
        }
    }
    
    func getCat(completion: @escaping (([GilCatInfo], Error?) -> Void)) {
        let storageRef = storagePath.collection("GilCatInfo")
        storageRef.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                completion([], error)
                return
            }
            var dataArr = [GilCatInfo]()
            for document in documents {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                    let decodedData = try JSONDecoder().decode(GilCatInfo.self, from: jsonData)
                    dataArr.append(decodedData)
                } catch {
                    completion([], error)
                    return
                }
            }
            completion(dataArr, nil)
        }
    }
}
