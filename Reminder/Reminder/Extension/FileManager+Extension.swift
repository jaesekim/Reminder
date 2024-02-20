//
//  FileManager+Extension.swift
//  Reminder
//
//  Created by 김재석 on 2/20/24.
//

import UIKit

extension UIViewController {
    
    // 고른 이미지를 document 파일에 저장
    func saveImageToDocument(image: UIImage, fileName: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }
        
        // 저장할 파일명 지정
        let fileUrl = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        // 압축
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 파일 저장, 외부 간섭 막기 위해 do - try-catch
        do {
            try data.write(to: fileUrl)
        } catch {
            print("File Save Error", error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {

        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return nil }
    
        // 저장할 파일명 지정
        let fileUrl = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        // 해당 경로에 실제로 파일 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileUrl.path()) {
            return UIImage(contentsOfFile: fileUrl.path())
        } else {
            // 없으면 기본 이미지
            return UIImage(systemName: "xmark")
        }
            
    }
}
