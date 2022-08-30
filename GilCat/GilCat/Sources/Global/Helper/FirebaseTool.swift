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

    // 파이어베이스에 고양이 객체 추가
    func addCat(newCat: GilCatInfo, completion: @escaping ((Error?) -> Void)) {
        let documentRef = storagePath.collection("GilCatInfo").document("Cat\(newCat.index)")
        let dictionary = newCat.dictionary
        documentRef.setData(dictionary) { error in
            completion(error)
        }
    }
    
    // 파이어베이스에서 고양이 객체들 가져오기
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
                            let cat = try change.element.document.data(as: GilCatInfo.self)
                            print("add \(cat.index)")
                            completion(-1, cat, nil)
                        } catch {
                            completion(-1, GilCatInfo(), error)
                        }
                    case .modified:
                        do {
                            let cat = try change.element.document.data(as: GilCatInfo.self)
                            print("modified \(cat.index)")
                            completion(cat.index, cat, nil)
                        } catch {
                            completion(-1, GilCatInfo(), error)
                        }
                    default:
                        completion(-1, GilCatInfo(), nil)
                    }
                }
            }
    }
    
    // 파이어베이스에 고양이 객체 수정
    func updateCat(updatingCat: GilCatInfo, completion: @escaping ((Error?) -> Void)) {
        let documentRef = storagePath.collection("GilCatInfo").document("Cat\(updatingCat.index)")
        let dictionary = updatingCat.dictionary
        documentRef.setData(dictionary) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func removeListener() {
        documentListener?.remove()
    }
}
