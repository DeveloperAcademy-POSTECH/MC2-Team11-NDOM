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
    private var documentListener: ListenerRegistration?
    
    func uploadCat(newCat: GilCatInfo, completion: @escaping ((Error?) -> Void)) {
        let storageRef = storagePath.collection("GilCatInfo")
        let dictionary = newCat.dictionary
        storageRef.addDocument(data: dictionary) { error in
            completion(error)
        }
    }
    
//    func getCat(completion: @escaping (([GilCatInfo], Error?) -> Void)) {
//        let storageRef = storagePath.collection("GilCatInfo")
//        storageRef.getDocuments { (snapshot, error) in
//            guard let documents = snapshot?.documents else {
//                completion([], error)
//                return
//            }
//            var dataArr = [GilCatInfo]()
//            for document in documents {
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())
//                    let decodedData = try JSONDecoder().decode(GilCatInfo.self, from: jsonData)
//                    dataArr.append(decodedData)
//                } catch {
//                    completion([], error)
//                    return
//                }
//            }
//            completion(dataArr, nil)
//        }
//    }
    
    func getCat(completion: @escaping ((Int, GilCatInfo, Error?) -> Void)) {
        removeListener()
        let storageRef = storagePath.collection("GilCatInfo")
        
        documentListener = storageRef
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    completion(-1, GilCatInfo(), error)
                    return
                }
                
                snapshot.documentChanges.enumerated().forEach { change in
                    switch change.element.type {
                    case .added:
                        do {
                            print("add \(change.offset)")
                            let cat = try change.element.document.data(as: GilCatInfo.self)
                            completion(-1, cat, nil)
                        } catch {
                            completion(-1, GilCatInfo(), error)
                        }
                    case .modified:
                        do {
                            print("modified \(change.offset)")
                            let cat = try change.element.document.data(as: GilCatInfo.self)
                            completion(change.offset, cat, nil)
                        } catch {
                            completion(-1, GilCatInfo(), error)
                        }
                    default:
                        completion(-1, GilCatInfo(), nil)
                    }
                }
            }
    }
    
    func removeListener() {
        documentListener?.remove()
    }
}
